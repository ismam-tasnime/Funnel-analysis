# Funnel-analysis
PostgreSQL-based marketing funnel analysis project covering user journey, conversion, drop-off, revenue, channel performance, ROI, and customer segmentation insights.
## Project Overview

This project is a complete *marketing funnel analysis* performed in *PostgreSQL. The goal was to understand how users move through a digital marketing journey from **Impression → Website Visit → Add to Cart → Purchase*, identify where users drop off, analyze channel performance, compare paid channel ROI, and study user behavior by time, weekday, country, segment, and device type.

A funnel is a customer journey framework that tracks users from awareness to purchase. In business analytics, funnel analysis helps identify where customers are converting, where they are leaving, and which marketing channels or user segments deserve more investment. Marketing funnels are commonly used to understand the customer journey from awareness to purchase and loyalty.  [oai_citation:0‡Amazon Ads](https://advertising.amazon.com/library/guides/marketing-funnel?utm_source=chatgpt.com)
This project helps answer important business questions such as:

- How many users enter each funnel stage?
- Where are users dropping off the most?
- Which channel brings the highest revenue?
- Which paid channel gives the best return on investment?
- Which weekday has the highest engagement?
- Which hour generates the most revenue?
- Which customer segment and device type performs best?
- How is revenue changing month over month?

---

# Tools & Skills Used

## Tools

- PostgreSQL
- SQL
- pgAdmin / SQL editor
- Excel for visual formatting and comparison

## SQL Concepts Used

- Fact and dimension table analysis
- Joins
- Aggregations
- Grouping
- Distinct counts
- Common Table Expressions
- Window functions
- Lag function
- Case statements
- Filter clause
- Date and time extraction
- Revenue analysis
- Funnel retention analysis
- Drop-off analysis
- ROI analysis
- Segment analysis
- Device analysis
- Channel performance analysis

---

PostgreSQL was used because it supports advanced analytical SQL features such as JOIN, GROUP BY, COUNT(DISTINCT), FILTER, CASE WHEN, CTEs, and window functions like LAG(), which are very useful for funnel, retention, drop-off, and ROI analysis.  [oai_citation:1‡PostgreSQL](https://www.postgresql.org/?utm_source=chatgpt.com)
# Database Structure

The project uses a star-schema style structure with one main fact table and multiple dimension tables.

---
## Tables Used

| Table Name | Purpose |
|---|---|
| dim_dates | Stores date-related information such as day, month, quarter, and year |
| dim_channel | Stores marketing channel details |
| dim_funnel_stages | Stores funnel stage names and order |
| dim_users | Stores user demographic and device details |
| fact_marketing_events | Stores all marketing event transactions |

---

# Table Details
<img src="images/Slide1.JPG" width="800">
# Business Purpose
This table acts as the date dimension. It stores calendar-related attributes that help convert raw timestamps into business-friendly reporting fields.
# Business Value
This table allows revenue, user activity, and funnel performance to be analyzed by day, month, quarter, and year.
<img src="images/Slide2.JPG" width="800">
<img src="images/Slide3.JPG" width="800">
<img src="images/Slide4.JPG" width="800">
<img src="images/Slide5.JPG" width="800">
<img src="images/Slide6.JPG" width="800">
<img src="images/Slide7.JPG" width="800">
<img src="images/Slide8.JPG" width="800">
<img src="images/Slide9.JPG" width="800">
<img src="images/Slide10.JPG" width="800">
<img src="images/Slide11.JPG" width="800">
<img src="images/Slide12.JPG" width="800">
<img src="images/Slide13.JPG" width="800">
<img src="images/Slide14.JPG" width="800">
<img src="images/Slide15.JPG" width="800">
<img src="images/Slide16.JPG" width="800">
<img src="images/Slide17.JPG" width="800">
<img src="images/Slide18.JPG" width="800">
<img src="images/Slide19.JPG" width="800">
<img src="images/Slide20.JPG" width="800">
<img src="images/Slide21.JPG" width="800">
<img src="images/Slide22.JPG" width="800">
