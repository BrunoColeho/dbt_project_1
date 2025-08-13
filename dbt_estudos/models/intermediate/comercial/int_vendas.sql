{{ config(tags=['comercial']) }}


with orders as (
    select 
    extract(month from order_date) as mes,
    extract(year from order_date) as ano,
    freight as total_frete
    from {{ref('stg_orders')}}
),
vendas as (
    select 
    CAST(mes as INT64) as mes,
    CAST(ano as INT64) as ano,
    ROUND(SUM(CAST(total_frete AS NUMERIC)), 2) AS total_frete
    from orders
    group by mes, ano
)

select * from vendas