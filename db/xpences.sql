DROP TABLE expenses;
DROP TABLE tags;
DROP TABLE merchants;

CREATE TABLE merchants (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    active BIT
);

CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    category VARCHAR(255),
    colour VARCHAR(255),
    active BIT
);

CREATE TABLE expenses (
    id SERIAL PRIMARY KEY,
    amount INT,
    date DATE,
    merchant_id INT REFERENCES merchants(id) ON DELETE SET NULL,
    tag_id INT REFERENCES tags(id) ON DELETE SET NULL
);