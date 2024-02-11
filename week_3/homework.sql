--- Preparation
CREATE OR REPLACE EXTERNAL TABLE `dtc-de-course-409315.ny_taxi.green_taxi_2022_external`
  OPTIONS (
    format ="PARQUET",
    uris = ['gs://dtc-de-course-409315-mage-bucket/green_taxi.parquet']
    );


CREATE OR REPLACE TABLE dtc-de-course-409315.ny_taxi.green_taxi_2022 AS
SELECT * FROM dtc-de-course-409315.ny_taxi.green_taxi_2022_external;

--- Number of rows
SELECT COUNT(*) FROM dtc-de-course-409315.ny_taxi.green_taxi_2022; 

SELECT DISTINCT(VendorID)
FROM dtc-de-course-409315.ny_taxi.green_taxi_2022;

SELECT DISTINCT(VendorID)
FROM dtc-de-course-409315.ny_taxi.green_taxi_2022_external;

--- zero fare amount
SELECT COUNT(*)
FROM dtc-de-course-409315.ny_taxi.green_taxi_2022_external
WHERE fare_amount=0.0