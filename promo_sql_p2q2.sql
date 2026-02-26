-- Return patients who had 3 consecutive NO_SHOWs at any point. 
-- Answer: (SQL Server) For this problem we’ll need a CTE and the function LAG. We first create our window function and inside we are going to select patient_id (since both tables have patient_id it’s easier to grab patient_id now since we just need appointments table), appt_date, and status. We’ll then need to select and use the lag function where it will LAG the status column meaning it’ll grab the previous row of status and then store it as a new column and partition by patient_id and order by appt_date so we make sure were getting the same patient and ordered by the appt_dates. We then do this again so it’ll get the past two (LAG(status, 2) previous rows of status and create a new column. This makes it easy for us in the outer query to find rows where the three status, prev_1 and prev_2 are all equal to NO_SHOW. Then we can close the CTE and then select distinct patient id and patient names from the ranked table we created then join it on the patients table. Then we lastly grab where the status is NO_SHOW, the previous status is NO_SHOW, and the second previous status is NO_SHOW.

with ranked AS (
  select patient_id, appt_date, status,
         LAG(status, 1) OVER (PARTITION BY patient_id ORDER BY appt_date) AS prev_1,
         LAG(status, 2) OVER (PARTITION BY patient_id ORDER BY appt_date) AS prev_2
  from appointments
)
select distinct p.patient_id, p.name
from ranked r
join patients p ON r.patient_id = p.patient_id
where r.status = 'NO_SHOW'
  and r.prev_1 = 'NO_SHOW'
  and r.prev_2 = 'NO_SHOW'
