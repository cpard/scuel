package tpch_queries

q14_template:
"""
select
    100.00 * sum(
        case
            when {{.schema.part.type}} like 'PROMO%' then {{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}})
            else 0
        end
    ) / sum({{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}})) as promorders_revenue
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.part.table_name}}
where
    {{.schema.lineitem.partkey}} = {{.schema.part.partkey}}
    and {{.schema.lineitem.shipdate}} >= date '{{.params.date}}'
    and {{.schema.lineitem.shipdate}} < date '{{.params.date}}' + interval '1' month
"""