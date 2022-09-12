package tpch_queries

q5_template:
"""
select
    {{.schema.nation.name}},
    sum({{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}})) as revenue
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.customer.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.region.table_name}}
where
    {{.schema.customer.custkey}} = {{.schema.orders.custkey}}
    and {{.schema.lineitem.orderkey}} = {{.schema.orders.orderkey}}
    and {{.schema.lineitem.suppkey}} = {{.schema.supplier.suppkey}}
    and {{.schema.customer.nationkey}} = {{.schema.supplier.nationkey}}
    and {{.schema.supplier.nationkey}} = {{.schema.nation.nationkey}}
    and {{.schema.nation.regionkey}} = {{.schema.region.regionkey}}
    and {{.schema.region.name}} = '{{.params.region}}'
    and {{.schema.orders.orderdate}} >= date '{{.params.date}}'
    and {{.schema.orders.orderdate}} < date '{{.params.date}}' + interval '1' year
group by
    {{.schema.nation.name}}
order by
    revenue desc
"""