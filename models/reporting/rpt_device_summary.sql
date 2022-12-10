/* 

このモデルは以下の例外を起こします

- Rejoining of Upstream Concepts

*/
{{
  config(
    materialized='view',
  )
}}

with session_count as (
  SELECT
    device_category
    , count(distinct ga_session_id) as session_count

  FROM
    {{ ref('fct_events') }}
  where device_category is not null
  group by device_category
)

select
  session_count.device_category
  , session_count.session_count
  , int_device_count.pv_count
from session_count
left outer join {{ ref('int_device_count') }} as int_device_count
  on session_count.device_category = int_device_count.device_category