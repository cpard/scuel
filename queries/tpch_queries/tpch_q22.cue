package tpch_queries

q22_template:
"""
select
    cntrycode,
    count(*) as numcust,
    sum(acctbal) as totacctbal
from
    (
        select
            substring(
                {{.schema.customer.phone}}
                from
                    1 for 2
            ) as cntrycode,
            {{.schema.customer.acctbal}}
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.customer.table_name}}
        where
            substring(
                {{.schema.customer.phone}}
                from
                    1 for 2
            ) in ('{{.params.i1}}','{{.params.i2}}', '{{.params.i3}}' , '{{.params.i4}}' , '{{.params.i5}}' , '{{.params.i6}}' , '{{.params.i7}}')
and {{.schema.customer.acctbal}} > (
select
avg({{.schema.customer.acctbal}})
from
{{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.customer.table_name}}
where
{{.schema.customer.acctbal}} > 0.00
and substring ({{.schema.customer.phone}} from 1 for 2) in ('{{.params.i1}}','{{.params.i2}}', '{{.params.i3}}' , '{{.params.i4}}' , '{{.params.i5}}' , '{{.params.i6}}' , '{{.params.i7}}')
)
and not exists (
select
*
from
{{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}}
where
{{.schema.orders.custkey}} = {{.schema.customer.custkey}}
)
) as custsale
group by
cntrycode
order by
cntrycode;
"""