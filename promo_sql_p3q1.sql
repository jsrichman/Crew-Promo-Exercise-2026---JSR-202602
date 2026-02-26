-- Count events by utm.campaign for US, CA in Q4 2025. 
-- Answer: (SQL Server) In this query we’ll need to grab attributes from the JSON payload and both events and users tables. So we want to select JSON_VALUE (to extract the value out of the JSON) for the utm.campaign. Then we need to select the country and the count as the event_count. Now since we need both tables we’ll need to join them together using user_id to connect events and users. Then the filters we need to filter to the values US or CA and then we’ll filter down the event time to just Q4 of 2025 which would be from October 1st to the end of December of 2025. Now we want the count of events per country so we’ll want to group by utm.campaign and country. Then we’ll just order them by country event_count to see the highest first.

select JSON_VALUE(e.payload_json, '$.utm.campaign') AS campaign, u.country, count(*) AS event_count
from events e
join users u ON u.user_id = e.user_id
where u.country IN ('US', 'CA')
and e.event_time >= '2025-10-01' and e.event_time <  '2026-01-01'
group by
    JSON_VALUE(e.payload_json, '$.utm.campaign'),
    u.country
order by
    u.country,
    event_count desc;
