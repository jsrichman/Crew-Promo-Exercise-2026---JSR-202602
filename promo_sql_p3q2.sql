-- Problem 3 Q2.) Extract multiple JSON fields (campaign, source) via a lateral parse if engine supports it 
-- (or repeat JSON_VALUE). 
-- Answer: (SQL Server) This query I went with repeated JSON VALUE (SQL Server) to extract campaign and source 
-- from the JSON payload. We selected both of our JSON values and then I just grabbed event_id from events in 
-- case we were to join with another table. To do this the other way we use the function CROSS JOIN LATERAL 
-- and then enclose our select of grabbing the JSON payload attributes we need of campaign and source 
-- (SELECT e.payload_json -> 'utm' ->> 'campaign' AS campaign) in the subquery.

select e.event_id, 
JSON_VALUE(e.payload_json, '$.utm.campaign') as campaign, 
JSON_VALUE(e.payload_json, '$.utm.source') as source
from events e

