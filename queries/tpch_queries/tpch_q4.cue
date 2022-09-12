package tpch_queries

q4_template:
"""
select
    {{.schema.orders.orderpriority}},
    count(*) as orderegioncount
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}}
where
    {{.schema.orders.orderdate}} >= date '{{.params.date}}'
    and {{.schema.orders.orderdate}} < date '{{.params.date}} + interval '3' month
    and exists (
        select
            *
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}}
        where
            {{.schema.lineitem.orderkey}} = {{.schema.orders.orderkey}}
            and {{.schema.lineitem.commitdate}} < {{.schema.lineitem.receiptdate}}
    )
group by
    {{.schema.orders.orderpriority}}
order by
    {{.schema.orders.orderpriority}}
"""