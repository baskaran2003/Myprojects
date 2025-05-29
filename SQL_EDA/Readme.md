# SQL EDA Project: Layoffs Dataset Analysis

## Project Overview

This project involves **cleaning and exploring layoff data** using **MySQL** to uncover meaningful insights and trends from global tech layoffs. It demonstrates SQL-based **data preprocessing**, **validation**, and **exploratory data analysis (EDA)**, making it ideal for data analysts and learners aiming to strengthen their SQL skills.

---

## Tools & Technologies

- **MySQL 8+**
- SQL (DDL, DML, CTEs, Window Functions)
- Dataset Source: `layoffs.csv`

---

## Objectives

- Clean and standardize raw data using SQL.
- Eliminate duplicates, NULLs, and inconsistencies.
- Perform EDA to identify trends by company, location, year, industry, and funding.

---

## Files Included

| File Name              | Description                                  |
|------------------------|----------------------------------------------|
| `layoffs.csv`          | Raw dataset containing company layoff data   |
| `Final_layoffs.csv`    | Cleaned version of the original dataset      |
| `Cleaning_data.sql`    | SQL scripts for cleaning and standardizing data |
| `EDA of layoffs.sql`   | SQL queries for analyzing patterns and trends |

---

##  Data Cleaning Summary (`Cleaning_data.sql`)

- Created staging tables and inserted data for processing.
- Removed exact duplicates using `ROW_NUMBER()` and `CTE`.
- Standardized fields:  
  - Trimmed whitespace in company/country fields  
  - Normalized industry names (e.g., grouped all `Crypto_*` to `Crypto`)  
  - Converted date formats to standard `DATE` type  
- Handled missing data:  
  - Deleted rows with NULL in both `total_laid_off` and `percentage_laid_off`  
  - Imputed missing industry values by cross-referencing similar records

---

## EDA Highlights (`EDA of layoffs.sql`)

- **Maximum Layoffs:** Identified companies with highest individual and total layoffs.
- **Layoff Percentages:** Found companies with 100% layoffs (full shutdowns).
- **Funding vs. Layoffs:** Ranked companies by funds raised vs. impact of layoffs.
- **Trends by Geography:** Aggregated data by country, location, and year.
- **Rolling Metrics:** Calculated rolling monthly total layoffs using window functions.
- **Top Companies by Year:** Used `DENSE_RANK()` to extract yearly top-3 affected companies.

---

## Sample Insights

- Startups with full layoffs often had low funding or single funding rounds.
- U.S. and India recorded the highest layoff volumes across tech hubs.
- Peak layoff months correlated with economic downturn indicators.

---

## Key Learning Outcomes

- End-to-end SQL workflow: Import → Clean → Analyze
- Real-world data handling: duplicate removal, NULL handling, standardization
- Intermediate-to-advanced SQL techniques: CTEs, `ROW_NUMBER()`, `DENSE_RANK()`, rolling aggregates

---

## Future Improvements

- Visualize trends using Tableau or Power BI
- Automate analysis using scheduled SQL jobs or Python integration
- Deploy insights as an interactive dashboard

---


