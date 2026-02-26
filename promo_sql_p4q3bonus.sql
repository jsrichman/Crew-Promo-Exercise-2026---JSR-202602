-- Bonus: How would you tweak to handle deletes if staging_accounts was a full dataset of all current accounts? 
-- Answer: We would want to do a soft delete rather than hard delete of our records is general best practice. Instead we can create a value of curr_rcd where we mark it as FALSE if the record is no longer needed so we're not completely removing it from our data. Since staging_accounts is the full dataset of all current accounts we can update dim_customers instead. My client uses curr_rcd_ind = ‘Y’ for all of their current records so I’ll do something similar where we add the column using alter table statement to our table dim_customer then we add column curr_rcd BOOLEAN DEFAULT TRUE where true is our default value and FALSE will be the inactive indicator. Then if the email becomes back to an active record we can alter this record back to TRUE. Then we can proceed by updating dim_customer and set curr_rcd as false where email is not in subquery select emails from staging accounts.

ALTER TABLE dim_customer ADD COLUMN curr_rcd BOOLEAN DEFAULT TRUE;

UPDATE dim_customer
SET curr_rcd = FALSE
where NOT EXISTS (
select 1 from staging_accounts where staging_accounts.email = dim_customer.email);
