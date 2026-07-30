
  
    



create or replace transient  table analytics.dbt_rfish.time_spine_monthly
    
    
    
    
    as (

with months as (

    
    select (
        

    dateadd(
        month,
        row_number() over (order by 1) - 1,
        to_date('01/01/2000','mm/dd/yyyy')
        )


    ) as date_month
    from table(flatten(input => array_generate_range(0, datediff(
        month,
        to_date('01/01/2000','mm/dd/yyyy'),
        to_date('01/01/2025','mm/dd/yyyy')
        ) )))


),

final as (
    select cast(date_month as date) as date_month
    from months
)

select * from final
-- filter the time spine to a specific range
where date_month >= date_trunc('month', dateadd(month, -48, current_timestamp())) 
  and date_month < date_trunc('month', dateadd(month, 12, current_timestamp()))
    )
;



  