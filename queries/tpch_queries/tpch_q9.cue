package tpch_queries

q9_template:
"""
select
    nation,
    orders_year,
    sum(amount) as sum_profit
from
    (
        select
            {{.schema.nation.name}} as nation,
            extract(
                year
                from
                    {{.schema.orders.orderdate}}
            ) as orders_year,
            {{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}}) - {{.schema.partsupp.supplycost}} * {{.schema.lineitem.quantity}} as amount
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.part.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.partsupp.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}}
        where
            {{.schema.supplier.suppkey}} = {{.schema.lineitem.suppkey}}
            and {{.schema.partsupp.suppkey}} = {{.schema.lineitem.suppkey}}
            and {{.schema.partsupp.partkey}} = {{.schema.lineitem.partkey}}
            and {{.schema.part.partkey}} = {{.schema.lineitem.partkey}}
            and {{.schema.orders.orderkey}} = {{.schema.lineitem.orderkey}}
            and {{.schema.supplier.nationkey}} = {{.schema.nation.nationkey}}
            and {{.schema.part.name}} like '%{{.params.color}}%'
    ) as profit
group by
    nation,
    orders_year
order by
    nation,
    orders_year desc
"""