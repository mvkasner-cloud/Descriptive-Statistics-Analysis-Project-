# Descriptive-Statistics-Analysis-Project-
#  Delivery Time Analysis Project

This project analyzes delivery times by region and product category to uncover key patterns, delays, and performance issues in logistics.

##  Goal

To calculate descriptive statistics and detect delays in order deliveries, using **SQL**, **Excel**, and **Tableau**. The aim is to understand:

- How fast orders are delivered
- Where the delays happen
- Which product categories and regions have performance issues
- Whether delivery time meets the SLA (≤ 7 days)

##  Tools Used

- **SQL Server Management Studio (SSMS)**  
  - Data cleaning  
  - Descriptive statistics (mean, median, std, etc.)  
  - Grouped statistics by Region and ProductCategory  
  - SLA analysis (delivery ≤ 7 days)  
  - Outlier detection using IQR

- **Microsoft Excel (365)**  
  - Frequency table  
  - Histogram, boxplot  
  - Coefficient of variation, skewness  
  - Key analytical findings summary

- **Tableau Public Desktop**  
  - Interactive dashboard  
  - Boxplots by region and category  
  - SLA compliance heatmap  
  - Delivery distribution & averages

##  Key Insights

- Most deliveries occur between **2–6 days**, peaking at **2–4 days**
- **20% of orders** exceed the 7-day SLA
- The distribution is **right-skewed** (Skew = 2.05), with outliers up to **19 days**
- **West region** and **Home category** show the **longest delays**
- **East region** performs **best overall**

  ##  Recommendations

- Focus on improving **Home** and **Electronics** categories
- **West region** needs urgent review due to consistent delays
- **East region** sets the benchmark for fast delivery

---

##  File Descriptions

- **DescrStat_DELIVERY_readyfor_Tableau.sql**  
  SQL code to clean data, compute stats, and perform grouped and SLA analysis

- **delivery_data_problematic_MY.xlsx**  
  Excel workbook with:
  - Cleaned dataset
  - Summary statistics
  - Frequency distribution and visuals
  - Written summary: key findings & recommendations

- **Delivery_Delivery by Region_BoxPlot__6036.twb**  
  Tableau dashboard with:
  - Delivery performance overview
  - SLA compliance rates
  - Avg delivery time by region and category
  - Outlier visualization (via boxplots)

[Tableau dashboar](DeliveryTimeDistribution.png)
[Exsel visualizations](EXCEL1.png)
[Exsel visualizations](EXCEL2.png)
[Exsel visualizations](Excel3.png)
