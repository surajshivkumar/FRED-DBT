-- models/marts/core/dim_state.sql

WITH state_data AS (
    SELECT DISTINCT
        state_code,
        CASE
            WHEN state_code = 'AL' THEN 'Alabama'
            WHEN state_code = 'AK' THEN 'Alaska'
            WHEN state_code = 'AZ' THEN 'Arizona'
            WHEN state_code = 'AR' THEN 'Arkansas'
            WHEN state_code = 'CA' THEN 'California'
            WHEN state_code = 'CO' THEN 'Colorado'
            WHEN state_code = 'CT' THEN 'Connecticut'
            WHEN state_code = 'DE' THEN 'Delaware'
            WHEN state_code = 'FL' THEN 'Florida'
            WHEN state_code = 'GA' THEN 'Georgia'
            WHEN state_code = 'HI' THEN 'Hawaii'
            WHEN state_code = 'ID' THEN 'Idaho'
            WHEN state_code = 'IL' THEN 'Illinois'
            WHEN state_code = 'IN' THEN 'Indiana'
            WHEN state_code = 'IA' THEN 'Iowa'
            WHEN state_code = 'KS' THEN 'Kansas'
            WHEN state_code = 'KY' THEN 'Kentucky'
            WHEN state_code = 'LA' THEN 'Louisiana'
            WHEN state_code = 'ME' THEN 'Maine'
            WHEN state_code = 'MD' THEN 'Maryland'
            WHEN state_code = 'MA' THEN 'Massachusetts'
            WHEN state_code = 'MI' THEN 'Michigan'
            WHEN state_code = 'MN' THEN 'Minnesota'
            WHEN state_code = 'MS' THEN 'Mississippi'
            WHEN state_code = 'MO' THEN 'Missouri'
            WHEN state_code = 'MT' THEN 'Montana'
            WHEN state_code = 'NE' THEN 'Nebraska'
            WHEN state_code = 'NV' THEN 'Nevada'
            WHEN state_code = 'NH' THEN 'New Hampshire'
            WHEN state_code = 'NJ' THEN 'New Jersey'
            WHEN state_code = 'NM' THEN 'New Mexico'
            WHEN state_code = 'NY' THEN 'New York'
            WHEN state_code = 'NC' THEN 'North Carolina'
            WHEN state_code = 'ND' THEN 'North Dakota'
            WHEN state_code = 'OH' THEN 'Ohio'
            WHEN state_code = 'OK' THEN 'Oklahoma'
            WHEN state_code = 'OR' THEN 'Oregon'
            WHEN state_code = 'PA' THEN 'Pennsylvania'
            WHEN state_code = 'RI' THEN 'Rhode Island'
            WHEN state_code = 'SC' THEN 'South Carolina'
            WHEN state_code = 'SD' THEN 'South Dakota'
            WHEN state_code = 'TN' THEN 'Tennessee'
            WHEN state_code = 'TX' THEN 'Texas'
            WHEN state_code = 'UT' THEN 'Utah'
            WHEN state_code = 'VT' THEN 'Vermont'
            WHEN state_code = 'VA' THEN 'Virginia'
            WHEN state_code = 'WA' THEN 'Washington'
            WHEN state_code = 'WV' THEN 'West Virginia'
            WHEN state_code = 'WI' THEN 'Wisconsin'
            WHEN state_code = 'WY' THEN 'Wyoming'
            -- U.S. Territories and other common codes
            WHEN state_code = 'DC' THEN 'District of Columbia'
            WHEN state_code = 'PR' THEN 'Puerto Rico'
            WHEN state_code = 'VI' THEN 'Virgin Islands'
            ELSE 'Unknown'
        END AS state_name
    FROM {{ ref('stg_fred_data') }}
)

SELECT
    state_code,
    state_name
FROM state_data
