package tpch_queries

q6_template:
"""
select
    sum({{.schema.lineitem.extendedprice}} * {{.schema.lineitem.discount}}) as revenue
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}}
where
    {{.schema.lineitem.shipdate}} >= date '{{.params.date}}'
    and {{.schema.lineitem.shipdate}} < date '{{.params.date}}' + interval '1' year
    and {{.schema.lineitem.discount}} between {{.params.discount}} - 0.01
    and {{.params.discount}} + 0.01
    and {{.schema.lineitem.quantity}} < {{.params.quantity}}
"""