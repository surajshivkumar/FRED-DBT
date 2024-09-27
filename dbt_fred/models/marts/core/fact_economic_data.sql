-- models/marts/core/fact_economic_data.sql

WITH fact_data AS (
    SELECT
        stg.date,
        stg.metric_value,
        stg.state_code,
        stg.metric
    FROM {{ ref('stg_fred_data') }} stg
)

SELECT
    d.date AS date_key,
    s.state_code AS state_key,
    m.metric_name AS metric_key,
    f.metric_value AS value
FROM fact_data f
JOIN {{ ref('dim_date') }} d ON f.date = d.date
JOIN {{ ref('dim_state') }} s ON f.state_code = s.state_code
JOIN {{ ref('dim_metric') }} m ON f.metric = m.metric_name
