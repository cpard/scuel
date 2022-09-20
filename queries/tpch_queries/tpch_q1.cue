package tpch_queries

q1_template:  """
select
    {{.schema.lineitem.returnflag}},
    {{.schema.lineitem.linestatus}},
    sum({{.schema.lineitem.quantity}}) as sum_qty,
    sum({{.schema.lineitem.extendedprice}}) as sum_base_price,
    sum(
        {{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}})
    ) as sum_disc_price,
    sum(
        {{.schema.lineitem.extendedprice}} * (1 - {{.schema.lineitem.discount}}) * (1 + {{.schema.lineitem.tax}})
    ) as sum_charge,
    avg({{.schema.lineitem.quantity}}) as avg_qty,
    avg({{.schema.lineitem.extendedprice}}) as avg_price,
    avg({{.schema.lineitem.discount}}) as avg_disc,
    count(*) as count_order
from
    {{if.db.schema}}{{.db.schema}}.{{else}}{{end}}{{.schema.lineitem.table_name}}
where
    {{.schema.lineitem.shipdate}} <= date '1998-12-01' - interval '{{.params.delta}} days'
group by
    {{.schema.lineitem.returnflag}},
    {{.schema.lineitem.linestatus}}
order by
    {{.schema.lineitem.returnflag}},
    {{.schema.lineitem.linestatus}};
"""

