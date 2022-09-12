package tpch_queries

q12_template:
"""
select
    {{.schema.lineitem.shipmode}},
    sum(
        case
            when {{.schema.orders.orderpriority}} = '1-URGENT'
            or {{.schema.orders.orderpriority}} = '2-HIGH' then 1
            else 0
        end
    ) as high_line_count,
    sum(
        case
            when {{.schema.orders.orderpriority}} <> '1-URGENT'
            and {{.schema.orders.orderpriority}} <> '2-HIGH' then 1
            else 0
        end
    ) as low_line_count
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}}
where
    {{.schema.orders.orderkey}} = {{.schema.lineitem.orderkey}}
    and {{.schema.lineitem.shipmode}} in ('{{.params.mode1}}', '{{.params.mode2}}')
    and {{.schema.lineitem.commitdate }}< {{.schema.lineitem.receiptdate}}
    and {{.schema.lineitem.shipdate}} < {{.schema.lineitem.commitdate}}
    and {{.schema.lineitem.receiptdate}} >= date '{{.params.date}}'
    and {{.schema.lineitem.receiptdate}} < date '{{.params.date}}' + interval '1' year
group by
    {{.schema.lineitem.shipmode}}
order by
    {{.schema.lineitem.shipmode}}
"""