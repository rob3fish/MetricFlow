
  create or replace   view analytics.dbt_rfish.stg_customers
  
  
  
  
  as (
    select * from raw.jaffle_shop.customers
  );

