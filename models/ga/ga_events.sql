{{
  config(
    materialized='table',
    partition_by={
      "field": "event_timestamp",
      "data_type": "timestamp",
      "granularity": "day"
    }
  )
}}

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