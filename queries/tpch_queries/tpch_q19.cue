package tpch_queries

q19_template:
"""
select
    sum({{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}})) as revenue
from
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}},
    {{if .db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.part.table_name}}
where
    (
        {{.schema.part.partkey}} = {{.schema.lineitem.partkey}}
        and {{.schema.part.brand}} = '{{.params.brand1}}'
        and {{.schema.part.container}} in ('SM CASE', 'SM BOX', 'SM PACK', 'SM PKG')
        and {{.schema.lineitem.quantity}} >= {{.params.quantity1}}
        and {{.schema.lineitem.quantity}} <= {{.params.quantity1}} + 10
        and {{.schema.part.size}} between 1 and 5
        and {{.schema.lineitem.shipmode}} in ('AIR', 'AIR REG')
        and {{.schema.lineitem.shipinstruct}} = 'DELIVER IN PERSON'
    )
    or (
        {{.schema.part.partkey}} = {{.schema.lineitem.partkey}}
        and {{.schema.part.brand}} = '{{.params.brand2}}'
        and {{.schema.part.container}} in ('MED BAG', 'MED BOX', 'MED PKG', 'MED PACK')
        and {{.schema.lineitem.quantity}} >= {{.params.quantity2}}
        and {{.schema.lineitem.quantity}} <= {{.params.quantity2}} + 10
        and {{.schema.part.size}} between 1 and 10
        and {{.schema.lineitem.shipmode}} in ('AIR', 'AIR REG')
        and {{.schema.lineitem.shipinstruct}} = 'DELIVER IN PERSON'
    )
    or (
        {{.schema.part.partkey}} = {{.schema.lineitem.partkey}}
        and {{.schema.part.brand}} = '{{.params.brand3}}'
        and {{.schema.part.container}} in ('LG CASE', 'LG BOX', 'LG PACK', 'LG PKG')
        and {{.schema.lineitem.quantity}} >= {{.params.quantity3}}
        and {{.schema.lineitem.quantity}} <= {{.params.quantity3}} + 10
        and {{.schema.part.size}} between 1 and 15
        and {{.schema.lineitem.shipmode}} in ('AIR', 'AIR REG')
        and {{.schema.lineitem.shipinstruct}} = 'DELIVER IN PERSON'
    )
"""