CREATE TABLE IF NOT EXISTS raw_fred_data (
    date DATE,                  -- Column to store the date of the observation
    value DECIMAL(10, 2),        -- Column to store the observed value (e.g., unemployment rate, GDP)
    state VARCHAR(50),          -- Column to store the full name of the state (e.g., "Florida")
    state_code VARCHAR(2),      -- Column to store the two-letter state code (e.g., "FL")
    metric VARCHAR(50)          -- Column to store the metric name (e.g., "unemployment_rate", "GDP")
);
