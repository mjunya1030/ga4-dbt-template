/* 

このモデルは以下の例外を起こします

- Multiple Sources Joined

*/

{{
  config(
    materialized='view'
  )
}}

with events as (
  SELECT
    user_pseudo_id,
    TIMESTAMP_MICROS(user_first_touch_timestamp) AS user_first_touch_timestamp,
    event_date,
    TIMESTAMP_MICROS(event_timestamp) AS event_timestamp,
    geo,
    device.category as device_category,
    traffic_source,
    (
      SELECT
        params.value.string_value
      FROM
        unnest(event_params) as params
      WHERE
        params.key = "campaign"
    ) as campaign,
    (
      SELECT
        params.value.string_value
      FROM
        unnest(event_params) as params
      WHERE
        params.key = "content"
    ) as content,
    event_name,
    (
      SELECT
        params.value.string_value
      FROM
        unnest(event_params) as params
      WHERE
        params.key = "event_label"
    ) as event_label,
    (
      SELECT
        params.value.string_value
      FROM
        unnest(event_params) as params
      WHERE
        params.key = "event_category"
    ) as event_category,
    (
      SELECT
        params.value.int_value
      FROM
        unnest(event_params) as params
      WHERE
        params.key = "percent_scrolled"
    ) as percent_scrolled,
    (
      SELECT
        params.value.string_value
      FROM
        unnest(event_params) as params
      WHERE
        params.key = "page_location"
    ) as page_location,
    (
      SELECT
        params.value.int_value
      FROM
        unnest(event_params) as params
      WHERE
        params.key = "ga_session_id"
    ) as ga_session_id,
  FROM
    {{ source('analytics_272722196', 'events_*') }}

)

select distinct
  {{ dbt_utils.surrogate_key('events.user_pseudo_id','events.event_timestamp','page_display_names.page_display_name') }}  as event_key
  , events.user_pseudo_id
  , events.event_timestamp
  , events.device_category
  , page_display_names.page_display_name
from events
left outer join {{ source('analytics_272722196', 'page_display_names') }} as page_display_names
  on events.page_location = page_display_names.page_location