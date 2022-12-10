/* 

このモデルは以下の例外を起こします

- direct_join_to_source
- is_empty_fct_source_fanout
- fct_model_directories

*/
{{
  config(
    materialized='table',
    on_schema_change='append_new_columns',
  )
}}


SELECT
  page_display_names.page_display_name
  , count(*) as access_count
FROM
  {{ ref('stg_events') }} as events
left outer join
  {{ source('analytics_272722196', 'page_display_names') }} as page_display_names
  on events.page_location = page_display_names.page_location
where page_display_name is not null
group by
  page_display_name
