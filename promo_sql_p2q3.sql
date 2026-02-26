-- Create a procedure sp_next_appts(@Region NULL, @FromDate, @ToDate) that returns upcoming scheduled appointments (filter region if provided). 
-- Answer: (SQL Server) For this query we want a stored procedure so we first start by creating a procedure and labeling it sp_next_appts. We need @Region, @FromDate, and @ToDate from the description of the question where @Region can be NULL. The we can start our query by doing “as” and then “begin” where we can now select * from patients table, but we also need the appointments table so we will join by patient_id. Our first where clause is the @Region where we want to create a filter where its possible Region is NULL or an actual value. Our next filter is using the @ToDate and @FromDate where we can filter by specific dates. Then the last filter will be appointment status is SCHEDULED. Then ordering by appt_date asc so the soonest upcoming appointments come first. Then finally closing the begin block by using “end”.

CREATE PROCEDURE sp_next_appts
    @Region VARCHAR(100) = NULL,
    @FromDate DATE,
    @ToDate DATE
AS
BEGIN
select * 
from patients p
join appointments a on p.patient_id = a.patient_id 
where(@Region IS NULL OR p.region = @Region)
and a.appt_date between @FromDate and @ToDate
and a.status = 'SCHEDULED'
order by a.appt_date asc
END
