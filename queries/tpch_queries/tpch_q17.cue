package tpch_queries

q17_template:
"""
select
    sum({{.schema.lineitem.extendedprice}}) / 7.0 as avg_yearly
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.part.table_name}}
where
    {{.schema.part.partkey}} = {{.schema.lineitem.partkey}}
    and {{.schema.part.brand}} = 'B{{.params.brand}}'
    and {{.schema.part.container}} = '{{.params.container_part1}} {{.params.container_part2}}'
    and {{.schema.lineitem.quantity}} < (
        select
            0.2 * avg({{.schema.lineitem.quantity}})
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}}
        where
            {{.schema.lineitem.partkey}} = {{.schema.part.partkey}}
    )
"""