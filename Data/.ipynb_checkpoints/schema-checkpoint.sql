-- Create card_holder table
DROP TABLE IF EXISTS card_holder;
CREATE TABLE card_holder (
    id SERIAL NOT NULL,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_card_holder PRIMARY KEY (
        id
     )
);

-- Create credit_card table
DROP TABLE IF EXISTS credit_card;
CREATE TABLE credit_card (
    card VARCHAR(20) NOT NULL,
    cardholder_id INT NOT NULL
);

-- Create merchant_category table
DROP TABLE IF EXISTS merchant_category;
CREATE TABLE merchant_category (
    id SERIAL   NOT NULL,
    name VARCHAR(255)   NOT NULL,
    CONSTRAINT pk_merchant_category PRIMARY KEY (
        id
     )
);

-- Create merchant table
DROP TABLE IF EXISTS merchant;
CREATE TABLE merchant (
    id SERIAL NOT NULL,
    name VARCHAR(255) NOT NULL,
    id_merchant_category INT NOT NULL,
    CONSTRAINT pk_merchant PRIMARY KEY (
        id
     )
);

-- Create transactions table
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions (
    id INT NOT NULL,
    date TIMESTAMP NOT NULL,
    amount FLOAT NOT NULL,
    card VARCHAR(20) NOT NULL,
    id_merchant INT NOT NULL,
    CONSTRAINT pk_transactions PRIMARY KEY (
        id
     )
);

-- Add foreign key constraints
ALTER TABLE credit_card ADD CONSTRAINT fk_credit_card_cardholder_id FOREIGN KEY(cardholder_id)
REFERENCES card_holder (id);

ALTER TABLE merchant ADD CONSTRAINT fk_merchant_id_merchant_category FOREIGN KEY(id_merchant_category)
REFERENCES merchant_category (id);

ALTER TABLE transactions ADD CONSTRAINT fk_transactions_id_merchant FOREIGN KEY(id_merchant)
REFERENCES merchant (id);