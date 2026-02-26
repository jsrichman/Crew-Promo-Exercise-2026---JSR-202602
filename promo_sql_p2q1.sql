-- Problem 2 Q1.) List patients with no appointments in the last 12 months, newest patients first. 
-- Answer: (SQL Server) For this query we want to select the patient id, patient name, and created at columns 
-- from patients. We need both tables for this query so we must join the appointments table to the patient 
-- table using patient_id but we want only the patients with no appointments. We will need a left join so that 
-- patients without a matching appointment in that window are still returned, just with NULL values in the 
-- appointment columns. Then we can reduce the appointments table down to any appointment dates in the past 12
-- months using dateadd and getdate. Then we need to filter only appointments status as NULL so we are not 
-- getting any appointments where it could be with a valid status value . Then we want the newest patients 
-- first so we just order by created_at and desc so the newest ones show first.

select p.patient_id, p.name, p.created_at
from patients p
left join appointments a on p.patient_id = a.patient_id 
and a.appt_date >= dateadd(month, -12, getdate())
where a.status IS NULL
order by p.created_at desc

