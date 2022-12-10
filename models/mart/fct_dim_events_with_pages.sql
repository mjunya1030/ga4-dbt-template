/* 

このモデルは以下の例外を起こします

- Model Fanout

*/

{{
  config(
    materialized='view',
  )
}}


SELECT
  events.page_location
  , events.event_timestamp
  , events.device_category
  , events.ga_session_id
  , events.event_date
  , events.user_pseudo_id
  , pages.page_display_name
FROM
  {{ ref('fct_events') }} as events
left outer join {{ ref('dim_pages') }} as pages
  on events.page_location = pages.page_location