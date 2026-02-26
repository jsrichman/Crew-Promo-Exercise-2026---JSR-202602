-- Return the top campaign by events per country in Q4 2025. 
-- Answer: (SQL Server) For this query we’ll want to do a CTE in order to get the top campaign. We’ll enclose our query with the function with ranked as () and then within the brackets we create our ranked campaigns. FIrst we select country, JSON_VALUE campaign, and the count(*) since we want the highest event count per country. We’ll also need to use the rank function to get the top country in event count so we rank over then partition by country and order by count descending to get the most at the top as rank. We need country as a column so we need to join the events table with the users table by joining on user_id. Then we need to filter down the event time to just Q4 of 2025 which would be from October 1st to the end of December of 2025. Then since we want the top campaigns by country from events we’ll group by country and campaign. Then enclosing this in our CTE, we can now query off of our CTE from ranked grabbing the country, campaign, and event_count where the rank is equal to 1 to get the top campaigns in event count by country.

with ranked as (
	select u.country, JSON_VALUE(e.payload_json, '$.utm.campaign') as campaign, count(*) as event_count, 
RANK() OVER (PARTITION BY u.country ORDER BY COUNT(*) DESC) AS rnk
	from events e
	join users u ON u.user_id = e.user_id
where e.event_time >= '2025-10-01' and e.event_time <  '2026-01-01'
group by country , JSON_VALUE(e.payload_json, '$.utm.campaign')
)
select country, campaign, event_count
from ranked 
where rnk =1

