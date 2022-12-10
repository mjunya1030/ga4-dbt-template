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
  , count(distinct ga_session_id) as session_count

FROM
  {{ ref('fct_events') }}
where device_category is not null
group by device_category
