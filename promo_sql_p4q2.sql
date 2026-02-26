-- Problem 4 Q2.) Assume ledger.amount can be text in some source, how would you handle that data in a safe manner 
-- to ensure it’s an amount? 
-- Answer: (PostgreSQL) We can handle this by using a specific regex. So when we query we would do a case statement 
-- when amount is not  '^-?[0-9]+(\.[0-9]+)?$' meaning if the number is negative or positive with decimals then make 
-- the amount a numeric value. Otherwise make the value NULL. This way if the amount is not in that structure it’ll 
-- be pushed to NULL.

select txn_id, account_id,
CASE
	WHEN amount ~ '^-?[0-9]+(\.[0-9]+)?$' THEN amount::NUMERIC(18,2)
ELSE NULL
END AS amount_clean
from ledger;

