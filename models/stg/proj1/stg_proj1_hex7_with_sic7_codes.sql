{{ config(enabled=True) }}

WITH hex7_with_sic7 AS (
  SELECT
    h.hex7,
    h.CAT_B,
    h.TaxYear as TaxYear,
    CONCAT(CAST(h.latitude as STRING), ", ", CAST(h.longitude as STRING)) AS location,
    h.FTE,
    s.sic7_1d_description AS industry_description,
    s.sic7_1d
  FROM {{ source('port_proj1_hex7_data', 'src_1_hex7_FTE_Industry5d_with_lat_long') }} h
  LEFT JOIN {{ source('port_proj1_hex7_data', 'src_1_sic7codes') }} s
  ON h.SIC7_5d = s.sic7_5d_numeric
)

SELECT
  hex7,
  industry_description,
  TaxYear,
  location,
  sic7_1d,
  SUM(CASE WHEN FTE = '<10' THEN 0 ELSE CAST(FTE AS FLOAT64) END) AS total_FTE
FROM hex7_with_sic7
GROUP BY hex7, industry_description, sic7_1d, TaxYear, location