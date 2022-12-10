/* 

このモデルは以下の例外を起こします

- Rejoining of Upstream Concepts

*/
{{
  config(
    materialized='view',
  )
}}


SELECT
  device_category
  , count(*) as pv_count

FROM
  {{ ref('fct_dim_events_with_pages') }}
group by device_category