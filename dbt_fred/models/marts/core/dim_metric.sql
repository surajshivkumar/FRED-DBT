
WITH metric_data AS (
    SELECT DISTINCT metric
    FROM {{ ref('stg_fred_data') }}
)

SELECT
    metric AS metric_name
FROM metric_data