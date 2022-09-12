package tpch_queries

q18_template:
"""
select
    {{.schema.customer.name}},
    {{.schema.customer.custkey}},
    {{.schema.orders.orderkey}},
    {{.schema.orders.orderdate}},
    {{.schema.orders.totalprice}},
    sum({{.schema.lineitem.quantity}})
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.customer.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}}
where
    {{.schema.orders.orderkey}} in (
        select
            {{.schema.lineitem.orderkey}}
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}}
        group by
            {{.schema.lineitem.orderkey}}
        having
            sum({{.schema.lineitem.quantity}}) > {{.params.quantity}}
    )
    and {{.schema.customer.custkey}} = {{.schema.orders.custkey}}
    and {{.schema.orders.orderkey}} = {{.schema.lineitem.orderkey}}
group by
    {{.schema.customer.name}},
    {{.schema.customer.custkey}},
    {{.schema.orders.orderkey}},
    {{.schema.orders.orderdate}},
    {{.schema.orders.totalprice}}
order by
    {{.schema.orders.totalprice}} desc,
    {{.schema.orders.orderdate}}
"""