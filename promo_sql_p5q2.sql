-- What was employee 123’s salary on 2025‑08‑15? 
-- Answer: For this problem we need a few columns from employee and comp_changes. First we need to select employee id, name, salary, effective_from and effective_to. Then we need to join our employees table with the comp_changes table using employee id. Then we filter to just employee id 123 and then since we have the effective_from column we want to find any record of this employee where their salary has changed so any time before or on 2025-08-15. This will get us this person's active salary as of 2025-08-15. Then we need our effective to filter to be anything on or after 2025-08-15 or NULL to understand if their salary is still the same. 

select e.emp_id, e.name, c.salary, c.effective_from, c.effective_to
	from employees e
	join comp_changes c on e.emp_id = c.emp_id
	where emp_id = 123 
and c.effective_from <= '2025-08-15' and (c.effective_to >= '2025-08-15' or c.effective_to IS NULL)
