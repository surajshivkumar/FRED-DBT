WITH date_data AS (
    SELECT DISTINCT CAST(date AS DATE) AS date
    FROM {{ ref('stg_fred_data') }}
)

SELECT
    date,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,
    EXTRACT(DAY FROM date) AS day,
    EXTRACT(QUARTER FROM date) AS quarter,
    EXTRACT(DOW FROM date) AS day_of_week
FROM date_data