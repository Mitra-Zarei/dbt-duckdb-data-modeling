# dbt-duckdb-data-modeling


# NYC Yellow Taxi Analytics with dbt

## 📌 Project Overview

This project demonstrates how to build, transform, and document a modern data pipeline using **dbt (Data Build Tool)** and **DuckDB** with the NYC Yellow Taxi dataset.

The objective was to:

- Import raw trip data from a Parquet file
- Transform and aggregate trip data
- Implement Jinja templating
- Create model dependencies using `ref()`
- Generate dbt documentation
- Validate outputs using a custom verification script

This project simulates a real-world analytics engineering workflow.

---

## 🛠 Tech Stack

- dbt (v1.5+)
- DuckDB
- SQL
- Jinja templating
- Parquet data files
- Git

---

## 📂 Project Structure

nyc_yellow_taxi/
│
├── models/
│   ├── taxi_rides_raw.sql
│   ├── total_creditcard_riders_by_day.sql
│   ├── total_amounts.sql
│   └── model_properties.yml
│
├── dbt_project.yml
├── profiles.yml
└── target/

---

## 🚀 Key Implementations

### Raw Data Model
```sql
select * 
from read_parquet('yellow_tripdata_2023-01-partial.parquet')
