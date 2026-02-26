-- Problem 5 Q1.) Return the chain of command with depth for each employee; prevent cycles. 
-- Answer: (PostgreSQL) This is a common recursion CTE SQL problem getting the hierarchy of individuals of a company. 
-- We want to wrap this problem around a CTE and call it something like employee_hierarchy. The first part in the 
-- inside query will begin grabbing the employee id, manager id, 0 as level, and our path which will use the ARRAY 
-- statement on [emp_id] where their manager_id is null where they do not have a manager hence top of the hierarchy. 
-- Then for recursion we need to use union all and select employee id and manager id again, we also want to grab level+1 
-- for the next level of employees from the employees table. We will also grab the combination of path and employee id. 
-- Then for recursion we need to inner join the employees table on our CTE employee_hierarchy where manager id (employees) 
-- is equal to the employee id (employee_hierarchy). Then to prevent cycles we add the filter where not employee id = any 
-- employee hierarchy path to prevent any loops. Then we can close out our CTE and query from our CTE grabbing the 
-- employee id, name, level, and path. Where we will order by path to get the order of hierarchy where the direct reports 
-- will be under the managers employee id.

with employee_hierarchy as (
	select emp_id, manager_id, 0 AS level, ARRAY[emp_id] AS path
	from employees e
	where manager_id is NULL
	union all
	select e.emp_id, e.manager_id, eh.level + 1, eh.path || e.emp_id
	from employees e
	inner join employee_hierarchy eh on e.manager_id = eh.emp_id
	where NOT e.emp_id = ANY(eh.path)
)
	select emp_id, name, level, path
from employee_hierarchy
order by path

