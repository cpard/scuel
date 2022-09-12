package tpch_queries

q21_template:
"""
select
    {{.schema.supplier.name}},
    count(*) as numwait
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}} l1,
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}}
where
    {{.schema.supplier.suppkey}} = l1.suppkey
    and {{.schema.orders.orderkey}} = l1.orderkey
    and {{.schema.orders.orderstatus}} = 'F'
    and l1.receiptdate > l1.commitdate
    and exists (
        select
            *
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}} l2
        where
            l2.orderkey = l1.orderkey
            and l2.suppkey <> l1.suppkey
    )
    and not exists (
        select
            *
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}} l3
        where
            l3.orderkey = l1.orderkey
            and l3.suppkey <> l1.suppkey
            and l3.receiptdate > l3.commitdate
    )
    and {{.schema.supplier.nationkey}} = {{.schema.nation.nationkey}}
    and {{.schema.nation.name}} = '{{.params.nation}}'
group by
    {{.schema.supplier.name}}
order by
    numwait desc,
    {{.schema.supplier.name}}
"""