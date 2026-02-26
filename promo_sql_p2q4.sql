-- Problem 2 Q4.) Create view vw_monthly_no_show_rate and discuss indexes (e.g., (patient_id, appt_date)), and 
-- partitioning by appt_date. 
-- Answer: To create a view using SQL Server we first need to call the function “create view” then name it 
-- vw_monthly_no_show_rate. From here we can use “AS” then create our query for the view. Since the view is asking 
-- for a monthly no shows rate, we will want to select first the appt_date and format it as the month of the specific 
-- year. Then we want to select count(*) as total_appointments, since appt_id is the primary key we can grab the 
-- count(*) at the total_appointments. We then need to grab the no show appts, we do that by doing a sum of case when 
-- appt status is NO_SHOW count it as a 1, if not then 0. Then finally we need to put it all together and grab the no 
-- show rate where we will want to cast this as a float since itll be a decimal then we can can again the sum of case 
-- when appt status is NO_SHOW count it as a 1, if not then 0 then dividing this by count(*) to get our no show rate. 
-- Again we need both tables so we will grab from the appointments table and then join onto the patients table using 
-- the patient_id. Then last since we're using SQL Server for this problem we’ll group by format a.appt_date to get 
-- the month of a specific year. To make it easier to filter this view we could partition this view by appt_date by 
-- months so the database will only scan for specific months. So query on a month of a date will only touch that 
-- specific month of data were filtering on. Then to quickly grab patient_ids and appt_date we could index these two 
-- columns since these columns are used often for joining on patient_id and then filtering with appt_date so indexing 
-- them helps scanning for matching rows instead of scanning the whole table.

CREATE VIEW vw_monthly_no_show_rate AS
select
    format(a.appt_date, 'yyyy-MM') AS appt_month,
    count(*) AS total_appointments,
    sum(CASE WHEN a.status = 'NO_SHOW' THEN 1 ELSE 0 END) AS no_shows,
    CAST(sum(CASE WHEN a.status = 'NO_SHOW' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS no_show_rate
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
GROUP BY format(a.appt_date, 'yyyy-MM')

