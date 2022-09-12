package tpch_queries

q11_template:
"""
select
    {{.schema.partsupp.partkey}},
    sum({{.schema.partsupp.supplycost}} * {{.schema.partsupp.availqty}}) as value
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.partsupp.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}}
where
    {{.schema.partsupp.suppkey}} = {{.schema.supplier.suppkey}}
    and {{.schema.supplier.nationkey}} = {{.schema.nation.nationkey}}
    and {{.schema.nation.name}} = '{{.params.nation}}'
group by
    {{.schema.partsupp.partkey}}
having
    sum({{.schema.partsupp.supplycost}} * {{.schema.partsupp.availqty}}) > (
        select
            sum({{.schema.partsupp.supplycost}} * {{.schema.partsupp.availqty}}) * {{.params.fraction}}
        from
            {{.schema.partsupp.table_name}},
            {{.schema.supplier.table_name}},
            {{.schema.nation.table_name}}
        where
            {{.schema.partsupp.suppkey}} = {{.schema.supplier.suppkey}}
            and {{.schema.supplier.nationkey}} = {{.schema.nation.nationkey}}
            and {{.schema.nation.name}} = '{{.params.nation}}'
    )
order by
    value desc
"""