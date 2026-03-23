# what percentage of users are churned
(with main as 
(select case when churned = "yes" then 1 else '0' end as churned_flag
from netflix_dataset)
select sum(churned_flag) / count(*) *100 as churned_rate
from main);

# churned rate by subscription
with net as 
(select subscription_type, case when churned = 'yes' then 1 else '0' end as churned_flag
from netflix_dataset)
select subscription_type, round((sum(churned_flag)/ count(*) *100),2) as churned_rate
from net
group by subscription_type
order by churned_rate desc;


# what characteristics do churned users share
select *
from netflix_dataset
where churned = 'yes';

# churned users by country

select country, count(*) as total_users, sum(case when churned= 'yes' then 1 else 0 end) as churned_users
from netflix_dataset
group by country
order by churned_users desc;


# does days since last login affect churned
select days_since_last_login, count(*) churned
from netflix_dataset
where churned ='yes'
group by days_since_last_login;

# which age_group watches the most
select count(user_id) as users,
case when age between 18 and 30 then '18-30' when age between 30 and 50 then '30-50'
when age between 50 and 70 then '50-70' else '70+' end as age_group
from netflix_dataset
where churned = 'no' 
group by age_group
order by users desc;

# users by country

select country, count(*) as total_users
from netflix_dataset
group by country
order by total_users desc;

# most popular genres and genres with the number of churned users
select favorite_genre, count(*) as total_users, sum(case when churned = "yes" then 1 else "0" end ) as churned_flag
from netflix_dataset
group by favorite_genre
order by total_users desc;

# high risk users who might churn 
select *
from netflix_dataset
where days_since_last_login >20
and watch_sessions_per_week <= 3
and recommendation_click_rate < 0.5;

create view netflix_view as (select user_id, age, gender, country, account_age_months,
subscription_type, monthly_fee, payment,primary_device, devices_used, favorite_genre,avg_watch_time_minutes,
days_since_last_login, churned 
from netflix_dataset
)





 