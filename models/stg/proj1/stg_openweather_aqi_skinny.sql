WITH formatted_outputs AS (
    SELECT 
        city_short_code,
        CONCAT(lat, ', ', lon) as coordinates,
        pollutant,
        max(value) as value,
        max(dt) as dt,
        last_updated
    FROM
        {{ source('openweather_data', 'src_openweather_aqi')}}
    GROUP BY
        city_short_code,
        coordinates,
        last_updated,
        pollutant
)

select * from formatted_outputs