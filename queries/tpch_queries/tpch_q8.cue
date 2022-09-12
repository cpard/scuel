package tpch_queries

q8_template:
"""
select
    orders_year,
    sum(
        case
            when nation = '{{.params.nation}}' then volume
            else 0
        end
    ) / sum(volume) as mkt_share
from
    (
        select
            extract(
                year
                from
                    {{.schema.orders.orderdate}}
            ) as orders_year,
            {{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}}) as volume,
            n2.name as nation
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.part.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.customer.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}} n1,
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}} n2,
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.region.table_name}}
        where
            {{.schema.part.partkey}} = {{.schema.lineitem.partkey}}
            and {{.schema.supplier.suppkey}} = {{.schema.lineitem.suppkey}}
            and {{.schema.lineitem.orderkey}} = {{.schema.orders.orderkey}}
            and {{.schema.orders.custkey}} = {{.schema.customer.custkey}}
            and {{.schema.customer.nationkey}} = n1.nationkey
            and n1.regionkey = {{.schema.region.regionkey}}
            and {{.schema.region.name}} = '{{.params.region}}'
            and {{.schema.supplier.nationkey}} = n2.nationkey
            and {{.schema.orders.orderdate}} between date '1995-01-01'
            and date '1996-12-31'
            and {{.schema.part.type}} = '{{.params.syllable1}} {{.params.syllable2}} {{.params.syllable3}}'
    ) as allineitem_nations
group by
    orders_year
order by
    orders_year
"""