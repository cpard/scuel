package tpch_queries

q15_template:
"""
with revenue as (
select
    {{.schema.lineitem.suppkey}} as supplier_no,
    sum({{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}})) as total_revenue
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}}
where
    {{.schema.lineitem.shipdate}} >= date '{{.params.date}}'
    and {{.schema.lineitem.shipdate}} < date '{{.params.date}}' + interval '3' month
group by {{.schema.lineitem.suppkey}})

select
    {{.schema.supplier.suppkey}},
    {{.schema.supplier.name}},
    {{.schema.supplier.address}},
    {{.schema.supplier.phone}},
    total_revenue
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}},
    revenue
where
    {{.schema.supplier.suppkey}} = revenue.supplier_no
    and total_revenue = (
        select
            max(total_revenue)
        from
            revenue
    )
order by
    {{.schema.supplier.suppkey}};
"""