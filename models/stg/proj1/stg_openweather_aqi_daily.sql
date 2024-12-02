WITH pivoted_data AS (
    SELECT
        city_short_code,
        CONCAT(lat, ', ', lon) as coordinates,
        last_updated,
        MAX(CASE WHEN pollutant = 'pm2_5' THEN value END) AS pm2_5,
        MAX(CASE WHEN pollutant = 'pm10' THEN value END) AS pm10,
        MAX(CASE WHEN pollutant = 'no2' THEN value END) AS no2,
        MAX(CASE WHEN pollutant = 'so2' THEN value END) AS so2,
        MAX(CASE WHEN pollutant = 'o3' THEN value END) AS o3,
        MAX(CASE WHEN pollutant = 'co' THEN value END) AS co
    FROM
        {{ source ('openweather_data', 'src_openweather_aqi') }}
    GROUP BY
        city_short_code,
        last_updated,
        coordinates 
)

SELECT * FROM pivoted_data