-- dim channel
select * from public.dim_channel
-- dim dates
select * from public.dim_dates
-- dim stages
select * from public.dim_funnel_stages
-- dim users
select * from public.dim_users
-- fact marketing events
select * from public.fact_marketing_events

-- visit count of user
select
user_id,
stage_id,
count(*) as total_visit
from public.fact_marketing_events
group by 1,2
having count(*)>'1'
order by 1 asc

-- (most of the time user came at stage 3 which is add to cart but they didnt purchase)


-- user countries
select 
distinct country,
count (user_id)
from public.dim_users
group by 1
-- several users from 80 different countries


-- total days of interaction
select 
count(distinct event_timestamp::date)
from public.fact_marketing_events


-- time analysis
select
count(distinct user_id),
extract (hour from event_timestamp::timestamp) as hours,
to_char(event_timestamp::timestamp,'day')as "weekday_name"
from public.fact_marketing_events
group by 2,3
order by hours asc

-- pick hour visit synopsis
with summary as
	(
	select
	user_id,
	extract (hour from event_timestamp::timestamp) as hours,
	lower(trim(to_char(event_timestamp::timestamp,'day')))as weekday_name,
	count(distinct user_id) as total
	from public.fact_marketing_events
 group by 1,2,3
	order by hours  asc

)
select 
hours,
 sum ( case WHEN weekday_name = 'monday' THEN total Else 0 end ) as monday,
 sum ( case WHEN weekday_name = 'tuesday' THEN total Else 0 end ) as tuesday,
 sum ( case WHEN weekday_name = 'wednesday' THEN total Else 0 end ) as wednesday,
 sum ( case WHEN weekday_name = 'thursday' THEN total Else 0 end ) as thursday,
 sum ( case WHEN weekday_name = 'friday' THEN total Else 0 end ) as friday,
 sum ( case WHEN weekday_name = 'saturday' THEN total Else 0 end ) as saturday,
 sum ( case WHEN weekday_name = 'sunday' THEN total Else 0 end ) as sunday
from summary
group by 1

-- which day has highest engagement?
SELECT

distinct (to_char(event_timestamp::timestamp,'day')) as weekday,
count(user_id)
FROM public.fact_marketing_events
group by 1
ORDER BY 2 DESC


-- rev analysis
with summary as
	(
	select
	user_id,
	extract (hour from event_timestamp::timestamp) as hours,
	lower(trim(to_char(event_timestamp::timestamp,'day')))as weekday_name,
	sum(revenue::numeric) as total
	from public.fact_marketing_events
 group by 1,2,3
	order by hours  asc

)
select 
hours,
 sum ( case WHEN weekday_name = 'monday' THEN total Else 0 end ) as monday,
 sum ( case WHEN weekday_name = 'tuesday' THEN total Else 0 end ) as tuesday,
 sum ( case WHEN weekday_name = 'wednesday' THEN total Else 0 end ) as wednesday,
 sum ( case WHEN weekday_name = 'thursday' THEN total Else 0 end ) as thursday,
 sum ( case WHEN weekday_name = 'friday' THEN total Else 0 end ) as friday,
 sum ( case WHEN weekday_name = 'saturday' THEN total Else 0 end ) as saturday,
 sum ( case WHEN weekday_name = 'sunday' THEN total Else 0 end ) as sunday
from summary
group by 1


-- funnel performance analysis
with funnel as
(
select 
distinct fm.stage_id,
s.stage_name,
count(distinct fm.user_id) as total_users,
lag(count(distinct fm.user_id)) over (order by fm.stage_id asc)::numeric as previous_stage_users
from public.fact_marketing_events as fm
join public.dim_funnel_stages as s on fm.stage_id::bigint=s.stage_id
group by 1,2
order by 1 asc
)
select 
*,
round((total_users/previous_stage_users)*100,2) as retention_rate
from funnel


-- dropoff analysis/
with dropoff as
(
select 
distinct fm.stage_id,
s.stage_name,
count(distinct fm.user_id) as total_users,
coalesce(lag(count(distinct fm.user_id)) over (order by fm.stage_id asc)::numeric,0) as previous_stage_users,
lag(count(distinct fm.user_id)) over (order by fm.stage_id asc)-count(distinct fm.user_id)::numeric  as drop_off
from public.fact_marketing_events as fm
join public.dim_funnel_stages as s on fm.stage_id::bigint=s.stage_id
group by 1,2
order by 1 asc
)
select 
*,
round((drop_off/previous_stage_users)*100,2) as drop_off_perc
from dropoff

-- MoM revenue analysis(growth/degrowth)

select
extract(month from event_timestamp::timestamp),
dd.month_name,

sum(revenue::numeric) as revenue,
lag(sum(revenue::numeric)) over (order by 1 asc ) as previous_month_rev,
round(((sum(revenue::numeric)-lag(sum(revenue::numeric)) over (order by 1 asc ))/nullif (sum(revenue::numeric),0))*100,2) as degrowth_percent
from public.fact_marketing_events as fm
join public.dim_dates as dd on fm.event_timestamp::date=dd.date_key
where fm.user_id is not null
and user_id::text <>' '
group by 1,2
order by 1 asc

-- channel performance analysis
select
c.channel_name,
count (distinct fm.user_id) as total_customer,
count (distinct fm.user_id) filter(where stage_id='4') as purchased_customer,
sum(fm.revenue::numeric)

from public.fact_marketing_events as fm
join public.dim_channel as c on fm.channel_id::bigint=c.channel_id
group by 1

-- Channel wise ROI analysis

with cost as
(select 
*,
case when stage_id='1' then 15
when stage_id='2' then 11
when stage_id='3'then 5
else 3
end as ad_cost
from 
public.dim_funnel_stages)
select * from cost
-- now
with stage as
(
select
f.user_id,stage_id,revenue,
c.channel_name,channel_category
from public.fact_marketing_events as f
inner join public.dim_channel as c on (f.channel_id::bigint)=c.channel_id
where channel_category='Paid'
),
 cost as
(select 
*,
case when stage_id='1' then 15
when stage_id='2' then 11
when stage_id='3'then 5
else 3
end as ad_cost
from 
public.dim_funnel_stages),
final as 
(
select 
s.channel_name,
sum(s.revenue::numeric) as rev,
sum(c.ad_cost) as invest
from stage as s
inner join cost as c on (s.stage_id::bigint)=(c.stage_id::bigint)
group by 1)
select *,
round((rev/invest)*100,2) as ROI
from final

-- USER AMALYSIS

select 
distinct user_segment,
count (user_id)
from public.dim_users
group by 1

-- DEVICE WISE AND SEGMENT WISE USER ANALYSIS
with stage as 
(select 
*,
case when stage_id='1' then 15
when stage_id='2' then 11
when stage_id='3'then 5
else 3
end as ad_cost
from 
public.dim_funnel_stages)
SELEct 
u.user_segment,
u.device_type,
count(u.user_id),
sum(s.ad_cost::numeric) AS INVEST,
sum(fm.revenue::numeric) AS REVENUE
from public.fact_marketing_events as fm 
join stage as s on fm.stage_id::bigint=s.stage_id::bigint
join public.dim_channel as c on c.channel_id::bigint=fm.channel_id::bigint
join public.dim_users as u on u.user_id=fm.user_id
where channel_category='Paid'
group by  1,2




















