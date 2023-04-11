-- Query #1: Isolate (or group) the transactions of each cardholder
CREATE VIEW cardholder_transactions AS
SELECT t.*, ch.id cardholder_id
FROM transactions t
LEFT JOIN credit_card cc ON t.card = cc.card
LEFT JOIN card_holder ch ON cc.cardholder_id = ch.id
GROUP BY t.date, t.id, ch.id
ORDER BY ch.id, t.card, t.date;

-- Query #2: Count the transactions that are less than $2.00 per cardholder.
CREATE VIEW cardholder_transactions_under_2 AS
SELECT cardholder_id, COUNT(id)
FROM cardholder_transactions
WHERE amount < 2
GROUP BY cardholder_id;