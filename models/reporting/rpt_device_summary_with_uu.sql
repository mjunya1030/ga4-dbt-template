/* 

このモデルは以下の例外を起こします

- Rejoining of Upstream Concepts

*/
{{
  config(
    materialized='view',
  )
}}

with uu_count as (
  SELECT
    device_category
    , count(distinct user_pseudo_id) as uu_count

  FROM
    {{ ref('fct_events') }}
  where device_category is not null
  group by device_category
)

select
  uu_count.device_category
  , uu_count.uu_count
  , rpt_device_summary.pv_count
  , rpt_device_summary.uu_count
from uu_count
left outer join {{ ref('rpt_device_summary') }} as rpt_device_summary
  on session_count.device_category = rpt_device_summary.device_category