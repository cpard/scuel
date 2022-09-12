package tpch_queries

q20_template:
"""
SELECT
    {{.schema.supplier.name}},
    {{.schema.supplier.address}}
FROM
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}}
WHERE
    {{.schema.supplier.suppkey}} IN (
        SELECT
            {{.schema.partsupp.suppkey}}
        FROM
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.partsupp.table_name}}
        WHERE
            {{.schema.partsupp.partkey}} IN (
                SELECT
                    {{.schema.part.partkey}}
                FROM
                    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.part.table_name}}
                WHERE
                    {{.schema.part.name}} LIKE '{{.params.color}}%'
            )
            AND {{.schema.partsupp.availqty}} > (
                SELECT
                    0.5 * SUM({{.schema.lineitem.quantity}})
                FROM
                    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}}
                WHERE
                    {{.schema.lineitem.partkey}} = {{.schema.partsupp.partkey}}
                    AND {{.schema.lineitem.suppkey}} = {{.schema.partsupp.suppkey}}
                    AND {{.schema.lineitem.shipdate}} >= CAST('{{.params.date}}' AS date)
                    AND {{.schema.lineitem.shipdate}} < CAST('{{.params.date}}' AS date) + interval '1' year
            )
    )
    AND {{.schema.supplier.nationkey}} = {{.schema.nation.nationkey}}
    AND {{.schema.nation.name}} = '{{.params.nation}}'
ORDER BY
    {{.schema.supplier.name}}
"""