/* 

このモデルは以下の例外を起こします

- fct_staging_dependent_on_marts_or_intermediate
- fct_staging_dependent_on_staging

*/
{{
  config(
    materialized='table',
    on_schema_change='append_new_columns',
  )
}}


SELECT
  {{ dbt_utils.surrogate_key('events.event_date','page_display_names.page_display_name') }} as event_page_key
  , events.event_date
  , page_display_names.page_display_name
  , count(*) as access_count
FROM
  {{ ref('fct_events') }} as events
left outer join {{ ref('stg_page_display_names') }} as page_display_names
on events.page_location = page_display_names.page_location
group by
  event_page_key, event_date, page_display_name
