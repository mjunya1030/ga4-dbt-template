/* 

このモデルは以下の例外を起こします

- root models
- fct_model_naming_conventions

*/
{{
  config(
    materialized='table',
    on_schema_change='append_new_columns',
  )
}}


SELECT
  device_category
  , count(*) as access_count
FROM
  dbt_ga4.fct_events 
group by
  device_category