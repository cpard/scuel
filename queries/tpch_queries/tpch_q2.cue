package tpch_queries

q2_template:
"""
select
    {{.schema.supplier.acctbal}},
    {{.schema.supplier.name}},
    {{.schema.nation.name}},
    {{.schema.part.partkey}},
    {{.schema.part.mfgr}},
    {{.schema.supplier.address}},
    {{.schema.supplier.phone}},
    {{.schema.supplier.comment}}
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.part.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.partsupp.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.region.table_name}}
where
    {{.schema.part.partkey}} = {{.schema.partsupp.partkey}}
    and {{.schema.supplier.suppkey}} = {{.schema.partsupp.suppkey}}
    and {{.schema.part.size}} = 15
    and part.type like '{{.params.type}}'
    and {{.schema.supplier.nationkey}} = {{.schema.nation.nationkey}}
    and {{.schema.nation.regionkey}} = {{.schema.region.regionkey}}
    and {{.schema.region.name}} = '{{.params.region}}'
    and {{.schema.partsupp.supplycost}} = (
        select
            min({{.schema.partsupp.supplycost}})
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.partsupp.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.region.table_name}}
        where
            {{.schema.part.partkey}} = {{.schema.partsupp.partkey}}
            and {{.schema.supplier.suppkey}} = {{.schema.partsupp.suppkey}}
            and {{.schema.supplier.nationkey}} = {{.schema.nation.nationkey}}
            and {{.schema.nation.regionkey}} = {{.schema.region.regionkey}}
            and {{.schema.region.name}} = '{{.params.region}}'
    )
order by
    {{.schema.supplier.acctbal}} desc,
    {{.schema.nation.name}},
    {{.schema.supplier.name}},
    {{.schema.part.partkey}}
"""