{{
  config(
    materialized='view'
  )
}}

SELECT 
  page_location
  , page_display_name
FROM
  {{ source('analytics_272722196', 'page_display_names') }}