/* NYC Yellow Taxi dbt Project – Full Workflow Showcase
dbt Model (Jinja)
 Compiled SQL
Bash Commands Used
*/

--  STEP 1: INITIALIZE PROJECT (BASH)
-- bash
-- dbt init nyc_yellow_taxi
-- cd nyc_yellow_taxi



-- STEP 2: BUILD RAW MODEL (PARQUET → DUCKDB)

-- File: models/taxi_rides_raw.sql

select *
from read_parquet('yellow_tripdata_2023-01-partial.parquet');



-- 🔹 STEP 3: AGGREGATION MODEL (JINJA VERSION)

-- File: models/total_creditcard_riders_by_day.sql

select 
    date_part('day', tpep_pickup_datetime) as day,
    count(*) as total_creditcard_riders_by_day
from {{ ref('taxi_rides_raw') }}
where payment_type = 1
group by 1
order by 1;


-- STEP 4: COMPILED VERSION (AFTER dbt compile)

-- bash
-- dbt compile

-- Compiled SQL (generated in target/compiled/...):

select 
    date_part('day', tpep_pickup_datetime) as day,
    count(*) as total_creditcard_riders_by_day
from main.taxi_rides_raw
where payment_type = 1
group by 1
order by 1;


-- STEP 5: JINJA LOOP EXAMPLE

-- File: models/total_amounts.sql

select
{% for column_name in ['fare_amount', 'tip_amount', 'tolls_amount', 'total_amount'] %}
  {{ column_name }}{% if not loop.last %},{% endif %}
{% endfor %}
from {{ ref('taxi_rides_raw') }};

--  STEP 6: BUILD MODELS (BASH)

-- bash
-- dbt run

--  FULL REFRESH (FOR INCREMENTAL MODELS)

-- bash
-- dbt run --full-refresh


-- STEP 7: GENERATE DOCUMENTATION

-- bash
-- dbt docs generate
-- dbt docs serve

--  STEP 8: VALIDATE OUTPUT

-- bash
-- ./datacheck

