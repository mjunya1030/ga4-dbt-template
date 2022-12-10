/* 

このモデルは以下の例外を起こします

- Model Fanout

*/
{{
  config(
    materialized='view',
  )
}}


with stg_events as (
  SELECT
    page_location
    , event_timestamp
    , device_category
    , ga_session_id
    , user_pseudo_id
    , event_date
    , row_number() over (partition by event_timestamp) as event_count

  FROM
    {{ ref('stg_events') }}
)

select
  {{ dbt_utils.surrogate_key('event_timestamp','event_count') }} as event_key
  , stg_events.*
from
  stg_events