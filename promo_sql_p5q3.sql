-- Only allow analysts to read their region’s users (Postgres example).
-- (Postgres) In order to limit analysts' read access to their region's user we need to enable row level security. We can do this by statement alter table (users) then enable row level security. From there we can create our policy and label it like analyst_region_policy. We do this ON the users table then we FOR SELECT TO analyst_role. Then grabbing the analyst region using the statement then setting the region to the current session region the user was assigned when logging in. We could get more in depth by using the department from the employees table if we want to limit it for the analytics department. Also we could also FORCE row level security if we wanted to avoid any bypasses.

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
create POLICY analyst_region_policy
ON users
FOR SELECT
TO analyst_role
USING (region = current_setting('app.current_region'));
