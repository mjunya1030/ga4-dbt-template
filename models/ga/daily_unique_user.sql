これは dbt run ではコンパイルしないクエリです。
メモとして残しています。

SELECT
  event_date,
  COUNT(DISTINCT user_pseudo_id) AS daily_unique_user
FROM
  `ganalytics-1312.analytics_272722196.events_*`
GROUP BY
  event_date