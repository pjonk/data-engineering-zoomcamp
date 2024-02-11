--- Preparation
CREATE OR REPLACE EXTERNAL TABLE `dtc-de-course-409315.ny_taxi.green_taxi_2022_external`
  OPTIONS (
    format ="PARQUET",
    uris = ['gs://dtc-de-course-409315-mage-bucket/green_taxi.parquet']
    );


CREATE OR REPLACE TABLE dtc-de-course-409315.ny_taxi.green_taxi_2022 AS
SELECT * FROM dtc-de-course-409315.ny_taxi.green_taxi_2022_external;

--- Question 1
--- Number of rows
SELECT COUNT(*) FROM dtc-de-course-409315.ny_taxi.green_taxi_2022; 

--- Question 2
SELECT COUNT(DISTINCT(VendorID))
FROM dtc-de-course-409315.ny_taxi.green_taxi_2022;

SELECT COUNT(DISTINCT(VendorID))
FROM dtc-de-course-409315.ny_taxi.green_taxi_2022_external;

--- Question 3
--- zero fare amount
SELECT COUNT(*)
FROM dtc-de-course-409315.ny_taxi.green_taxi_2022_external
WHERE fare_amount=0.0;

--- Question 4
-- Create a partitioned and clustered table
CREATE OR REPLACE TABLE dtc-de-course-409315.ny_taxi.green_taxi_2022_partition_cluster 
PARTITION BY lpep_pickup_date
CLUSTER BY VendorID AS
SELECT * FROM dtc-de-course-409315.ny_taxi.green_taxi_2022_external;

--- Question 5
SELECT COUNT(DISTINCT(VendorID))
FROM dtc-de-course-409315.ny_taxi.green_taxi_2022
WHERE DATE(lpep_pickup_date) BETWEEN '2022-06-01' AND '2022-06-30';

SELECT COUNT(DISTINCT(VendorID))
FROM dtc-de-course-409315.ny_taxi.green_taxi_2022_partition_cluster
WHERE DATE(lpep_pickup_date) BETWEEN '2022-06-01' AND '2022-06-30';