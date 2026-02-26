-- Problem 3 Q4.) Propose a Materialized View for daily events by country/campaign with partitioning on event_time 
-- and indexes on (country, event_time).
-- Answer: (PostgreSQL) In order to create a materialized view you have to start with the statement ‘create 
-- materialized view view_name’ followed by a ‘as’. Then after we can start our query for this view. We want 
-- a simple query where we can grab the daily events by country and or campaign. So we first select event_time, 
-- however we just want the day since we want daily so we simply do DATE_TRUNC and ‘day’ for the event_time day. 
-- We then select country and campaign using the JSON_VALUE to grab. Then lastly select the event_count so we 
-- can get the count of events. We’ll need both tables of events and users so we will join both on user_id. 
-- Then we group by our aggregate event_time as day, country, and campaign (JSON_VALUE). Then to close the 
-- materialized view we end with “WITH DATA”. The second part of the question is asking about partitions on event_time 
-- so we can create a table where we partition of events from the values of Q4 which would be between 2025-10-01 to 
-- 2026-01-01. Then the next part is asking about indexing on country and event_date, we can do this by creating an 
-- index on our index name on our materialized view for (country, event_date).

create MATERIALIZED VIEW mv_daily_events
AS
select DATE_TRUNC('day', e.event_time) AS event_date, u.country, JSON_VALUE(e.payload_json, '$.utm.campaign') AS campaign, count(*) AS event_count
from events e
join users u on u.user_id = e.user_id
group by
DATE_TRUNC('day', e.event_time),
u.country,
JSON_VALUE(e.payload_json, '$.utm.campaign')
WITH DATA;

CREATE TABLE events_2025_q4 PARTITION OF events
	FOR VALUES FROM ('2025-10-01') TO ('2026-01-01');

CREATE INDEX idx_country_date 
	ON mv_daily_events (country, event_date);

