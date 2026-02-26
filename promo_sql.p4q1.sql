-- Atomic Transactions: Suppose your application needs to debit account 1 by $100 and credit account 2 by $100, write some sql code to update those accounts; rollback on any error. 
-- Answer: (PostgreSQL) In order to update the table accounts we need to use the UPDATE statement. We also want to make sure there's a rollback on any error so we wrap the update’s in DO $$ and $$ with an exception block after the update with rollback and raise if there’s any errors. Now in order to start an update statement we want to first call BEGIN and then we can UPDATE our table accounts and set balance = balance minus 100 for debit to account 1 and the UPDATE or accounts table and set balance = balance + 100 for credit to account 2. Then we proceed with our exception block and then finally ending with the statement “END”.

DO $$
BEGIN
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
EXCEPTION
WHEN OTHERS THEN
ROLLBACK;
RAISE;
END;
$$;
