
WITH yearly_unemployment AS (
    -- Aggregate monthly unemployment data to yearly averages
    SELECT
        f.state_key,
        d.year,
        AVG(f.value) AS avg_unemployment_rate
    FROM {{ ref('fact_economic_data') }} f
    JOIN {{ ref('dim_date') }} d ON f.date_key = d.date
    WHERE f.metric_key = 'unemployment_rate'
    GROUP BY f.state_key, d.year
),

unemployment_change AS (
    -- Calculate year-over-year change in unemployment rate
    SELECT
        state_key,
        year,
        avg_unemployment_rate,
        LAG(avg_unemployment_rate, 1) OVER (PARTITION BY state_key ORDER BY year) AS prev_year_unemployment,
       (avg_unemployment_rate - LAG(avg_unemployment_rate, 1) OVER (PARTITION BY state_key ORDER BY year)) AS unemployment_change
    FROM yearly_unemployment
),

gdp_data AS (
    -- Use yearly GDP data
    SELECT
        f.state_key,
        d.year,
        f.value AS gdp_value,
        LAG(f.value, 1) OVER (PARTITION BY f.state_key ORDER BY d.year) AS prev_year_gdp
    FROM {{ ref('fact_economic_data') }} f
    JOIN {{ ref('dim_date') }} d ON f.date_key = d.date
    WHERE f.metric_key = 'GDP'
),

gdp_growth AS (
    -- Calculate GDP growth rate
    SELECT
        state_key,
        year,
        gdp_value,
        ((gdp_value - prev_year_gdp) / prev_year_gdp) * 100 AS gdp_growth_rate
    FROM gdp_data
    WHERE prev_year_gdp IS NOT NULL
),

joined_data AS (
    -- Join unemployment change data with GDP growth data
    SELECT
        u.state_key,
        u.year,
        u.unemployment_change,
        g.gdp_growth_rate
    FROM unemployment_change u
    JOIN gdp_growth g
        ON u.state_key = g.state_key
        AND u.year = g.year
    WHERE u.prev_year_unemployment IS NOT NULL
)

-- Final query to output the data
SELECT
    s.state_name,
    j.year,
    j.unemployment_change,
    j.gdp_growth_rate
FROM joined_data j
JOIN {{ ref('dim_state') }} s ON j.state_key = s.state_code
ORDER BY s.state_name, j.year
