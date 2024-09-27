WITH raw_data AS (
    SELECT
        date,
        value AS metric_value,
        state_code,
        metric
    FROM {{ source('fred_data_source', 'raw_fred_data') }}  -- Use source() to refer to the raw table
)

SELECT 
    CAST(date AS DATE) AS date,
    CAST(metric_value AS DECIMAL(10, 2)) AS metric_value,
    state_code,
    metric
FROM raw_data
