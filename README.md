# Customer Experience & E-Commerce Performance Investigation Using SQL, Python, Power BI & GenAI

## 📌 Project Overview

This project focuses on analyzing **customer experience and e-commerce performance** using **SQL, Python, Power BI, and GenAI**.

The objective is to transform raw e-commerce data into meaningful business insights by performing data cleaning, exploratory data analysis, SQL analysis, visualization, and dashboard development.

The project demonstrates an end-to-end **Data Analyst workflow**, from understanding raw data to presenting actionable insights through an interactive Power BI dashboard.

---

## 🎯 Project Objectives

* Analyze e-commerce sales and customer data.
* Identify patterns in customer purchasing behavior.
* Investigate customer experience and business performance.
* Clean and prepare raw data for analysis.
* Perform exploratory data analysis using Python.
* Write SQL queries to answer business questions.
* Create an interactive Power BI dashboard.
* Identify important KPIs and trends.
* Generate meaningful business insights using data.
* Use GenAI to support analysis and documentation.

---

## 🛠️ Tools & Technologies

| Tool                     | Purpose                               |
| ------------------------ | ------------------------------------- |
| **SQL**                  | Data querying and business analysis   |
| **Python**               | Data cleaning, EDA and analysis       |
| **Pandas**               | Data manipulation                     |
| **NumPy**                | Numerical analysis                    |
| **Matplotlib / Seaborn** | Data visualization                    |
| **Power BI**             | Interactive dashboard and reporting   |
| **DAX**                  | KPI calculations and measures         |
| **GenAI**                | Analysis assistance and documentation |

---

## 🔄 Project Workflow

```text
Raw Data
   ↓
Data Understanding
   ↓
Data Cleaning
   ↓
Exploratory Data Analysis
   ↓
SQL Analysis
   ↓
KPI & Business Analysis
   ↓
Power BI Dashboard
   ↓
Insights & Recommendations
```

---

# 1. 📂 Data Understanding

The first step is to understand the available datasets and their structure.

Key activities include:

* Understanding tables and columns.
* Identifying data types.
* Checking missing values.
* Checking duplicate records.
* Identifying invalid values.
* Understanding relationships between datasets.
* Identifying important business metrics.

---

# 2. 🧹 Data Cleaning

Data cleaning is performed before analysis to improve data quality.

### Key cleaning activities

* Handle missing/null values.
* Remove duplicate records.
* Identify and handle invalid values.
* Check incorrect data types.
* Standardize categorical values.
* Check quantity and price fields.
* Validate customer-related information.
* Handle invalid or inconsistent records.

The cleaned dataset is then used for further analysis.

---

# 3. 🐍 Python Exploratory Data Analysis

Python is used to explore the dataset and identify important patterns.

### Libraries Used

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
```

### EDA Activities

* Univariate analysis
* Bivariate analysis
* Multivariate analysis
* Descriptive statistics
* Missing-value analysis
* Outlier detection
* Correlation analysis
* Distribution analysis
* Customer and sales analysis

### Example

```python
df.head()
df.info()
df.describe()
df.isnull().sum()
df.duplicated().sum()
```

---

# 4. 🗄️ SQL Analysis

SQL is used to answer business questions from the cleaned data.

### SQL analysis includes

* Total sales/revenue analysis
* Customer analysis
* Product analysis
* Order analysis
* Quantity analysis
* Category analysis
* Performance analysis
* Customer purchasing patterns

### Example SQL Query

```sql
SELECT
    CustomerID,
    COUNT(*) AS Total_Orders
FROM sales
GROUP BY CustomerID
ORDER BY Total_Orders DESC;
```

SQL helps convert raw transactional data into useful business information.

---

# 5. 📊 Key Performance Indicators

Important KPIs can be calculated to measure e-commerce performance.

Examples include:

* Total Revenue
* Total Orders
* Total Customers
* Total Quantity Sold
* Average Order Value
* Average Sales
* Customer Purchase Frequency
* Product Performance
* Category Performance

---

# 6. 📈 Power BI Dashboard

Power BI is used to build an interactive dashboard for business reporting.

### Dashboard Components

* KPI Cards
* Sales/Revenue trends
* Customer analysis
* Product analysis
* Category analysis
* Interactive slicers
* Bar charts
* Line charts
* Tables
* Filters

### Example DAX Measures

```DAX
Total Revenue =
SUM(Sales[Revenue])
```

```DAX
Total Orders =
COUNT(Sales[OrderID])
```

```DAX
Total Customers =
DISTINCTCOUNT(Sales[CustomerID])
```

```DAX
Average Revenue =
AVERAGE(Sales[Revenue])
```

---

# 7. 🤖 GenAI

GenAI is used as a supporting tool during the project for activities such as:

* Understanding analytical problems.
* Generating ideas for business questions.
* Supporting SQL query development.
* Explaining analytical results.
* Improving documentation.
* Helping communicate insights clearly.

GenAI is used as an **analytical assistant**, while the final analysis and validation are based on the underlying data.

---

# 8. 🔍 Business Questions

The project can be used to investigate questions such as:

1. What is the total revenue generated?
2. How many orders were placed?
3. How many unique customers are present?
4. Which products generate the most revenue?
5. Which categories perform best?
6. What are the purchasing patterns of customers?
7. Which customers place the highest number of orders?
8. What trends can be observed over time?
9. Are there unusual values or outliers in the transaction data?
10. What factors are associated with e-commerce performance?

---

# 9. 💡 Key Insights

The analysis is intended to identify:

* Revenue trends
* Customer purchasing patterns
* High-performing products
* High-performing categories
* Customer activity
* Order behavior
* Data-quality issues
* Potential business opportunities

> **Note:** Final insights should be added after completing the SQL, Python, and Power BI analysis. They should be based on actual results rather than assumptions.

---

# 10. 📁 Project Structure

```text
Customer-Experience-E-Commerce-Performance/
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── sql/
│   └── analysis_queries.sql
│
├── python/
│   └── EDA.ipynb
│
├── powerbi/
│   └── ecommerce_dashboard.pbix
│
├── screenshots/
│   └── dashboard.png
│
├── README.md
└── requirements.txt
```

---

# 11. 🚀 How to Run the Project

### Step 1 — Prepare the Data

Place the raw datasets inside the `data/raw/` folder.

### Step 2 — Data Cleaning

Use Python/Pandas to clean and prepare the datasets.

### Step 3 — Exploratory Data Analysis

Open the Python notebook:

```text
python/EDA.ipynb
```

Run the analysis cells to explore the data.

### Step 4 — SQL Analysis

Load the cleaned dataset into the selected SQL database and execute the queries from:

```text
sql/analysis_queries.sql
```

### Step 5 — Power BI

Open:

```text
powerbi/ecommerce_dashboard.pbix
```

Refresh the data and interact with the dashboard.

---

# 📌 Project Outcome

This project demonstrates an end-to-end **Data Analyst workflow** using multiple industry-relevant tools:

**SQL → Python → EDA → Business Analysis → Power BI → Dashboard → Insights**

It showcases practical skills in:

* Data Cleaning
* SQL
* Python
* Exploratory Data Analysis
* Data Visualization
* Power BI
* DAX
* KPI Development
* Business Analysis
* Data Storytelling
* GenAI-assisted analytics

---

## 👩‍💻 Skills Demonstrated

```text
SQL
Python
Pandas
NumPy
EDA
Data Cleaning
Data Visualization
Power BI
DAX
KPI Analysis
Business Analysis
Data Storytelling
GenAI
```
## 👤 Project Author
Dnyaneshwari Madake

Data Analytics Portfolio Project

Focus Areas:
Power BI • SQL • Excel • Data Analysis • Business Intelligence AI 
---

## 📜 License

This project is created for educational and portfolio purposes.
