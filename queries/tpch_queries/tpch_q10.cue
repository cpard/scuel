package tpch_queries

q10_template:
"""
select
    {{.schema.customer.custkey}},
    {{.schema.customer.name}},
    sum({{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}})) as revenue,
    {{.schema.customer.acctbal}},
    {{.schema.nation.name}},
    {{.schema.customer.address}},
    {{.schema.customer.phone}},
    {{.schema.customer.comment}}
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.customer.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}}
where
    {{.schema.customer.custkey}} = {{.schema.orders.custkey}}
    and {{.schema.lineitem.orderkey}} = {{.schema.orders.orderkey}}
    and {{.schema.orders.orderdate}} >= date '{{.params.date}}'
    and {{.schema.orders.orderdate}} < date '{{.params.date}}' + interval '3' month
    and {{.schema.lineitem.returnflag}} = 'R'
    and {{.schema.customer.nationkey}} = {{.schema.nation.nationkey}}
group by
    {{.schema.customer.custkey}},
    {{.schema.customer.name}},
    {{.schema.customer.acctbal}},
    {{.schema.customer.phone}},
    {{.schema.nation.name}},
    {{.schema.customer.address}},
    {{.schema.customer.comment}}
order by
    revenue desc
"""