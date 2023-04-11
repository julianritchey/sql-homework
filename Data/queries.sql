-- Query #1: Group all transactions per card
CREATE VIEW card_transactions AS
SELECT *
FROM transactions
GROUP BY card, id
ORDER BY card, date;

-- Query #2a: List all transactions that are less than $2.00 per card.
CREATE VIEW card_transactions_under_2 AS
SELECT *
FROM card_transactions
WHERE amount < 2
ORDER BY card, date;

-- Query #2b: Count all transactions that are less than $2.00 per card.
CREATE VIEW count_transactions_under_2 AS
SELECT card, COUNT(id)
FROM card_transactions
WHERE amount < 2
GROUP BY card
ORDER BY COUNT(id) DESC;

-- Query #3: List the 100 largest transactions under $2.00 made from 7:00 am through to 9:00 am.
CREATE VIEW largest_trans_7_to_9 AS
SELECT *
FROM card_transactions_under_2
WHERE date_part('hour', date) >= 7 AND date_part('hour', date) < 9
ORDER BY amount DESC
LIMIT 100;

-- Query #4: List the transactions made outside 7:00 am and 9:00 am.
CREATE VIEW trans_outside_7_to_9 AS
SELECT *
FROM card_transactions_under_2
WHERE date_part('hour', date) < 7 OR date_part('hour', date) >= 9
ORDER BY amount DESC;

-- Query #5: List the top 5 merchants with small transactions.CREATE VIEW trans_outside_7_to_9 AS
CREATE VIEW merchants_under_2 AS
SELECT name, COUNT(ct.id) trans_under_2
FROM card_transactions_under_2 ct
LEFT JOIN merchant m ON ct.id_merchant = m.id
GROUP BY m.name
ORDER BY COUNT(ct.id) DESC;