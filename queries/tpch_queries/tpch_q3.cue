package tpch_queries

q3_template:
"""
select
    {{.schema.lineitem.orderkey}},
    sum({{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}})) as revenue,
    {{.schema.orders.orderdate}},
    {{.schema.orders.shippriority}}
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.customer.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}}
where
    {{.schema.customer.mktsegment}} = '{{.params.segment}}'
    and {{.schema.customer.custkey}} = {{.schema.orders.custkey}}
    and {{.schema.lineitem.orderkey}} = {{.schema.orders.orderkey}}
    and {{.schema.orders.orderdate}} < date '{{.params.date}}'
    and {{.schema.lineitem.shipdate}} > date '{{.params.date}}'
group by
    {{.schema.lineitem.orderkey}},
    {{.schema.orders.orderdate}},
    {{.schema.orders.shippriority}}
order by
    revenue desc,
    {{.schema.orders.orderdate}}
"""