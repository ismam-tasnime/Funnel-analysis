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

##Business Purpose
This table stores marketing channel information.

##Business Value
This table helps compare the performance of different acquisition channels and identify which channels generate users, purchases, revenue, and ROI.

<img src="images/Slide2.JPG" width="800">

## Business Purpose
This table acts as the date dimension. It stores calendar-related attributes that help convert raw timestamps into business-friendly reporting fields.

## Business Value
This table allows revenue, user activity, and funnel performance to be analyzed by day, month, quarter, and year.

<img src="images/Slide3.JPG" width="800">

## Business Purpose
This table defines the funnel journey.

## Business Value
This table gives business meaning to the raw stage_id values in the fact table. It allows conversion and drop-off analysis across the customer journey.

<img src="images/Slide4.JPG" width="800">

## Business Purpose
This table contains user-level attributes.

## Business Value
This table supports segmentation analysis, allowing the business to understand which users and devices are more valuable.

<img src="images/Slide5.JPG" width="800">

## Business Purpose
This is the main fact table that stores every marketing event.

## Business Value
This table is the foundation of the project. It connects users, channels, funnel stages, and revenue.

<img src="images/Slide6.JPG" width="800">

## Business Problem
The business wants to identify users who interacted with the same funnel stage more than once.

## SQL Concept Used

* GROUP BY
* COUNT(*)
* HAVING
* Positional grouping using GROUP BY 1,2

## Business Insight
This query finds repeat interactions. For example, some users viewed impressions multiple times or reached a stage more than once.

## Business Solution

*Users with repeated visits can be retargeted because they show higher intent. For example:
* Users with repeated impressions but no visit may need better ad creatives.
* Users with repeated add-to-cart events may need discount reminders.
* Users with repeated visits but no purchase may need remarketing.

<img src="images/Slide7.JPG" width="800">

## Business Problem
The business wants to know from which countries users are coming.

## SQL Concept Used

* DISTINCT
* COUNT
* GROUP BY

## Business Insight
The dataset contains users from many countries. The screenshot notes that users came from around 80 different countries.

## Business Solution
Country-level analysis helps the marketing team decide where to localize campaigns, which regions need more budget, and where conversion potential exists.

<img src="images/Slide8.JPG" width="800">

## Business Problem
The business wants to know how many unique days had marketing activity.

## SQL Concept Used
* COUNT(DISTINCT)
* Type casting timestamp to date using event_timestamp::date

## Result
The dataset contains activity across 59 unique days.

## Business Insight
This means the funnel analysis is based on nearly two months of interaction data.

## Business Solution
The business can use this time window to monitor campaign performance, compare weekly behavior, and identify revenue trends.

<img src="images/Slide9.JPG" width="800">
<img src="images/Slide10.JPG" width="800">

## Business Problem
The business wants to know which hours and weekdays generate the most user visits.

## SQL Concept Used
* CTE using WITH
* EXTRACT(HOUR FROM timestamp)
* TO_CHAR() for weekday extraction
* LOWER() and TRIM() for text cleaning
* Pivoting with SUM(CASE WHEN ...)

## Business Insight
This query creates a weekday-hour engagement matrix. It helps identify when customers are most active.

## Business Solution
Use high-engagement hours for:
* Ad scheduling
* Email campaign timing
* Push notification timing
* Social media posting
* Website promotion windows

<img src="images/Slide11.JPG" width="800">

## Business Problem
The business wants to identify which day has the highest engagement.

## Business Insight
Wednesday is the strongest engagement day, followed by Monday and Sunday. Friday has the lowest engagement.

## Business Solution
* Increase campaign activity on Wednesday.
* Test promotional campaigns on Monday and Sunday.
* Review why Friday engagement is weak.
* Avoid wasting high ad spend on low-engagement days unless testing new creatives.


<img src="images/Slide12.JPG" width="800">
<img src="images/Slide13.JPG" width="800">

## Business Problem
The business wants to identify which hour and weekday combination generates revenue.

## SQL Concept Used
* CTE
* Revenue aggregation
* Timestamp extraction
* Pivoting using CASE WHEN
* Numeric casting using revenue::numeric

## Business Insight
Revenue is concentrated in a small number of time slots. The strongest revenue event happened on Friday at 01:00, while Wednesday also produced strong revenue around late morning and early afternoon.

## Business Solution
* Schedule revenue-focused campaigns around proven purchase windows.
* Investigate why high engagement days do not always match high revenue days.
* Build separate strategies for traffic generation and purchase conversion.


<img src="images/Slide14.JPG" width="800">

 ### Revenue vs Visit Hour Comparison

## Business Problem
The business wants to compare whether high visit hours also generate high revenue.

## Business Insight
The comparison shows that high traffic does not always equal high revenue. Some hours may generate many visits but no purchase revenue, while specific hours generate revenue despite lower engagement.

## Business Solution
The business should not optimize only for traffic. It should optimize for:
* Revenue per visit
* Conversion rate by hour
* Campaign timing
* Purchase-intent behavior


<img src="images/Slide15.JPG" width="800">

## Business Problem
The business wants to understand how many users are retained from one funnel stage to the next.

## SQL Concept Used
* COUNT(DISTINCT user_id)
* JOIN
* LAG() window function
* CTE
* Retention percentage calculation

## Business Insight
* From Impression to Website Visit, retention is 59.46%.
* Add to Cart shows 104.55%, which means more unique users appeared in Add to Cart than Website Visit.
* Purchase retention is only 21.74%, showing a major conversion issue at the final stage.

## Important Analytical Note
The 104.55% Add to Cart retention suggests that the data is not strictly sequential. This can happen when users are counted independently at each stage rather than tracked as a true ordered funnel.

## Business Solution
* Fix or validate funnel event tracking.
* Ensure users follow the correct event order.
* Investigate why many add-to-cart users do not purchase.
* Improve checkout flow, pricing, trust signals, and cart recovery campaigns.
  

<img src="images/Slide16.JPG" width="800">

## Business Problem
The business wants to identify the biggest leakage point in the funnel.

## Business Insight
The biggest drop-off is from Add to Cart to Purchase, where 78.26% of users did not complete the purchase.

## Business Solution
This is the most important business finding of the project.

## Recommended actions:
* Simplify checkout steps.
* Add abandoned cart email campaigns.
* Offer limited-time discounts.
* Improve payment options.
* Add trust badges and return policy visibility.
* Analyze shipping cost or delivery-time friction.
* Retarget add-to-cart users with paid ads.


<img src="images/Slide17.JPG" width="800">

 ## Business Problem
The business wants to monitor monthly revenue movement.

## Business Insight
Revenue decreased from January to February and again from February to March. January was the best revenue month.

## Business Solution
* Investigate what campaigns ran in January.
* Compare channel mix by month.
* Review whether paid spend decreased.
* Check if purchase drop-off increased in later months.
* Relaunch successful January campaigns.

<img src="images/Slide18.JPG" width="800">

## Business Problem
The business wants to know which channel brings users, purchases, and revenue.

## SQL Concept Used
* JOIN
* COUNT(DISTINCT)
* FILTER
* Revenue aggregation

## Business Insight
* Organic Search generated the highest revenue: 391.35
* TikTok generated 210.07 revenue
* Email generated 235.39 revenue
* Google Ads brought 12 customers but generated 0 purchases and 0 revenue

## Business Solution
* Increase investment in Organic Search because it has strong revenue and purchase performance.
* Review Google Ads targeting, landing page, and campaign quality.
* Continue testing TikTok because it generated revenue.
* Use Email for nurturing because it produced strong revenue with fewer purchase customers.

<img src="images/Slide19.JPG" width="800">

## Business Problem
The business wants to know which paid channel gives the best return on marketing investment.

## SQL Concept Used
* Multiple CTEs
* Paid channel filtering
* Simulated ad cost by funnel stage
* Revenue-to-investment calculation
* ROI calculation

## Business Insight
TikTok is the best paid channel, with ROI of 101.00%. Google Ads generated zero revenue despite investment.

##  Business Solution
* Scale TikTok budget carefully.
* Pause or optimize Google Ads before increasing spend.
* Improve Facebook creative and targeting.
* Compare ROI with conversion rate before final budget decisions.

## Why This Query Is Important
This is one of the strongest business queries in the project because it connects marketing cost, revenue, and profitability. ROI is a core business metric used to compare return against investment cost.

<img src="images/Slide20.JPG" width="800">

##  Business Problem
The business wants to understand the user base composition.

## Business Insight
The audience is balanced across New, Returning, and VIP users.

## Business Solution
* New users need onboarding and trust-building.
* Returning users need remarketing and product recommendations.
* VIP users need loyalty rewards and premium offers.

<img src="images/Slide21.JPG" width="800">
<img src="images/Slide22.JPG" width="800">

## Business Problem
The business wants to understand how paid marketing performs across user segment and device type.

## Business Insight
The strongest paid revenue came from Returning users on Mobile, generating 210.07 revenue. New users on Tablet generated 20.95 revenue. Other combinations had investment but no revenue.

## Business Solution
* Focus paid remarketing on Returning Mobile users.
* Investigate why VIP users did not generate paid revenue.
* Review paid campaigns on Desktop and Tablet because most combinations had spend but no revenue.
* Improve mobile landing pages because mobile returning users converted best.



#### Final Business Findings

## Key Insights

1. Wednesday has the highest engagement
    * Wednesday generated 21 interactions.
    * Friday had the lowest engagement with 9 interactions.
2. Revenue is concentrated in specific time slots
    * Friday 01:00 generated 235.39.
    * Wednesday 11:00 and 13:00 generated strong revenue.
    * Tuesday 10:00 also generated revenue.
3. Biggest funnel problem is checkout conversion
    * Add to Cart to Purchase drop-off is 78.26%.
    * This is the most critical business issue.
4. Organic Search is the best overall revenue channel
    * Organic Search generated 391.35 revenue.
    * It also had 2 purchased customers.
5. TikTok is the best paid ROI channel
    * TikTok generated 101.00% ROI.
    * Google Ads generated 0 revenue from paid investment.
6. Returning Mobile users are the strongest paid segment
    * Returning Mobile users generated 210.07 revenue.
7. Monthly revenue is declining
    * January revenue was the highest.
    * February and March showed revenue decline.

⸻

## Business Recommendations

1. Fix Purchase Funnel Drop-Off

The largest loss happens between Add to Cart and Purchase. The business should improve checkout experience, reduce friction, and launch cart recovery campaigns.

2. Increase Organic Search Effort

Organic Search generated the highest revenue. The business should invest in SEO, content marketing, product pages, and search intent optimization.

3. Scale TikTok Carefully

TikTok produced the best paid ROI. More budget can be tested, but scaling should be controlled and measured weekly.

4. Optimize or Pause Google Ads

Google Ads generated users but no revenue. This suggests weak targeting, poor landing page match, or low purchase intent.

5. Use Wednesday for Engagement Campaigns

Wednesday had the highest engagement. Awareness and traffic campaigns should be tested on this day.

6. Target Returning Mobile Users

Returning Mobile users produced the strongest paid revenue. Retargeting and mobile-first campaigns should focus on this segment.

7. Build Revenue Per Visit KPI

The business should not only track visits. It should track revenue per visit, conversion rate, and cost per purchase.

## Project Conclusion

This funnel analysis project shows how PostgreSQL can be used to convert raw marketing event data into business insights.
The most important finding is that the business has a serious drop-off between Add to Cart and Purchase, where 78.26% of users are lost. This means the biggest opportunity is not only bringing more traffic, but improving the final conversion step.
From a channel perspective, Organic Search is the strongest revenue channel, while TikTok is the best paid ROI channel. Google Ads needs optimization because it generated spend but no revenue.
From a user behavior perspective, Wednesday is the strongest engagement day, and Returning Mobile users are the most valuable paid segment.
Overall, this project proves the power of SQL-based funnel analysis for marketing decision-making, budget optimization, customer journey improvement, and revenue growth.
