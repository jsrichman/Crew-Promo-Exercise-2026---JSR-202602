-- Show some SQL to Upsert staging_accounts into dim_customer (newer updated_at wins) and insert any new records. 
--Answer: (PostgreSQL) In order to upsert a table into another table we need to use the statement “insert into”. So we want to insert into email and updated_at. We then select the columns email and updated_at from our base table of staging_accounts. Then we want to use the statement on conflict (email), this will check to see if the email already exists in dim_customer. This will also add new records if there is no conflict meaning the email didn’t exist in dim_customer. On conflict works on dim_customer because email in dim_customer is unique. Then we want the newer records so we use statement do update set updated_at = excluded.updated_at where excluded.updated_at is greater than dim_customer.updated_at. Using this statement gives the newer wins condition where it'll overwrite the old record from staging_accounts. 

INSERT INTO dim_customer (email, updated_at)
select email, updated_at
from staging_accounts
ON CONFLICT (email)
DO UPDATE SET
updated_at = EXCLUDED.updated_at
where EXCLUDED.updated_at > dim_customer.updated_at;
