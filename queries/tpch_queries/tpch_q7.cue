package tpch_queries

q7_template:
"""
select
    supp_nation,
    cust_nation,
    lineitem_year,
    sum(volume) as revenue
from
    (
        select
            n1.name as supp_nation,
            n2.name as cust_nation,
            extract(
                year
                from
                    {{.schema.lineitem.shipdate}}
            ) as lineitem_year,
            {{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}}) as volume
        from
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.supplier.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.orders.table_name}},
           {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.customer.table_name}},
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}} n1,
            {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.nation.table_name}} n2
        where
            {{.schema.supplier.suppkey}} = {{.schema.lineitem.suppkey}}
            and {{.schema.orders.orderkey}} = {{.schema.lineitem.orderkey}}
            and {{.schema.customer.custkey}} = {{.schema.orders.custkey}}
            and {{.schema.supplier.nationkey}} = n1.nationkey
            and {{.schema.customer.nationkey}} = n2.nationkey
            and (
                (
                    n1.name = '{{.params.nation1}}'
                    and n2.name = '{{.params.nation2}}'
                )
                or (
                    n1.name = '{{.params.nation2}}'
                    and n2.name = '{{.params.nation1}}'
                )
            )
            and {{.schema.lineitem.shipdate}} between date '1995-01-01'
            and date '1996-12-31'
    ) as shipping
group by
    supp_nation,
    cust_nation,
    lineitem_year
order by
    supp_nation,
    cust_nation,
    lineitem_year
"""