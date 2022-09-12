package tpch_queries

q16_template:
"""
select
    {{.schema.part.brand}},
    {{.schema.part.type}},
    {{.schema.part.size}},
    count(distinct {{.schema.partsupp.suppkey}}) as supplieregion_cnt
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.partsupp.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.part.table_name}}
where
    {{.schema.part.partkey}} = {{.schema.partsupp.partkey}}
    and {{.schema.part.brand}} <> '{{.params.brand}}'
    and part.type not like '{{.params.type_part1}} {{.params.type_part2}}%'
    and part.size in ({{.params.size1}}, {{.params.size2}}, {{.params.size3}}, {{.params.size4}}, {{.params.size5}}, {{.params.size6}}, {{.params.size7}}, {{.params.size8}})
    and {{.schema.partsupp.suppkey}} not in (
        select
            {{.schema.supplier.suppkey}}
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}}
        where
            {{.schema.supplier.comment}} like '%Customer%Complaints%'
    )
group by
   {{.schema.part.brand}},
    {{.schema.part.type}},
    {{.schema.part.size}}
order by
    supplieregion_cnt desc,
    {{.schema.part.brand}},
    {{.schema.part.type}},
    {{.schema.part.size}}
"""