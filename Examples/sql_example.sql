SELECT `faa_identifier`, AVG(`elevation`) AS `avg_elevation`
FROM `bigquery-public-data.faa.us_airports`
GROUP BY `faa_identifier`
ORDER BY `avg_elevation` DESC
LIMIT 10
