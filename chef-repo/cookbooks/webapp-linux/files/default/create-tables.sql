CREATE TABLE customers(
    id CHAR (32) NOT NULL,
    PRIMARY KEY(id),
    first_name VARCHAR(64),
    last_name VARCHAR(64),
    email VARCHAR(64)
);

INSERT INTO customers (id, first_name, last_name, email) VALUES(uudi(), 'Tony', 'Stark', 'iron.man@devopsplus.co')
INSERT INTO customers (id, first_name, last_name, email) VALUES(uudi(), 'aaa', 'bbb', 'random@devopsplus.co')