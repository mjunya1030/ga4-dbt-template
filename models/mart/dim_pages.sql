/* 

このモデルは以下の例外を起こします

- fct_marts_or_intermediate_dependent_on_source

*/
{{
  config(
    materialized='view',
  )
}}


SELECT
  page_display_names.page_display_name
  , page_display_names.page_location
FROM
  {{ ref('stg_page_display_names') }} as page_display_names