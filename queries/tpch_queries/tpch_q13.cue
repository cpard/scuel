package tpch_queries

q13_template:
"""
SELECT
    customer_count,
    COUNT(*) AS custdist
FROM
    (
        SELECT
            {{.schema.customer.custkey}},
            COUNT({{.schema.orders.orderkey}}) AS customer_count
        FROM
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.customer.table_name}}
            LEFT OUTER JOIN orders ON {{.schema.customer.custkey}} = {{.schema.orders.custkey}}
            AND {{.schema.orders.comment}} NOT LIKE '%{{.params.word1}}%{{.params.word2}}%'
        GROUP BY
            {{.schema.customer.custkey}}
    ) AS customer_orders
GROUP BY
    customer_count
ORDER BY
    custdist DESC,
    customer_count DESC
"""