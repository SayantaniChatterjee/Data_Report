use Google_playstore_db;

-- Identifying null values
select * 
from googleplaystore
where App is null
or Category is null
or Rating is null
or Reviews is null
or Size is null
or Installs is null
or Type is null
or Price is null
or Content_Rating is null
or Genres is null
or Last_Updated is null
or Current_Ver is null
or Android_Ver is null;

-- Removing null values
delete from googleplaystore
where App is null
or Category is null
or Rating is null
or Reviews is null
or Size is null
or Installs is null
or Type is null
or Price is null
or Content_Rating is null
or Genres is null
or Last_Updated is null
or Current_Ver is null
or Android_Ver is null;

-- Overview of dataset
select * from googleplaystore;

-- Total App
select
count(distinct App) as Total_Apps
from googleplaystore;

-- Total Category
select
count(distinct Category) as Total_Categories
from googleplaystore;

-- App Category Distribution
select top 10 Category,
count(distinct App) as Total_Apps
from googleplaystore
group by Category
order by Total_Apps desc;

-- Top-rated Free Apps
select top 10 App,
Category,
Rating,
Reviews
from googleplaystore
where Type = 'Free' and Rating <> 'NaN'
order by Rating desc;

-- Top Reviewed Apps
select top 10 App,
max(try_cast(Reviews as int)) as Total_Review
from googleplaystore
group by App
order by Total_Review desc;

-- Average Rating by Category
select top 10 Category,
AVG(try_cast(Rating as float)) as Avg_Rating
from googleplaystore
group by Category
order by Avg_Rating desc;

-- App Update Frequency Analysis
select
App, year(try_cast(Last_Updated as date)) as Last_Updated_Year
from googleplaystore;

-- Sentiment Spectrum Across Categories
select top 10 Category,
avg(try_cast(Sentiment_Polarity as float)) as Avg_Sentiment_Polarity
from googleplaystore
join googleplaystore_user_reviews
on googleplaystore.App = googleplaystore_user_reviews.App
group by Category
order by Avg_Sentiment_Polarity desc;

-- Sentiment Spread by Category
select top 10 Category,
Sentiment,
count(*) as total_sentiment
from googleplaystore
join googleplaystore_user_reviews
on googleplaystore.App = googleplaystore_user_reviews.App
where Sentiment <> 'Nan'
group by Category, Sentiment
order by total_sentiment desc;

