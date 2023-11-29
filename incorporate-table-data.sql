USE sales_order_data;

DROP TABLE IF EXISTS dnorm_data;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS orders_table;
DROP TABLE IF EXISTS shipment;
DROP TABLE IF EXISTS payment;

CREATE TABLE customers(
    customer_id int PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    customer_segment VARCHAR(50),
    customer_country VARCHAR(50),
    row_no int
);

CREATE TABLE product(
    product_id int PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150),
    product_category VARCHAR(100),
    product_market VARCHAR(100),
    row_no int
);

CREATE TABLE order_table(
    order_id int PRIMARY KEY AUTO_INCREMENT,
    order_date timestamp,
    customer_id int,
    product_id int,
    row_no int,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
    ON DELETE CASCADE,
    FOREIGN KEY(product_id) REFERENCES product(product_id) ON DELETE CASCADE
);


CREATE TABLE shipment(
    shipment_id int PRIMARY KEY AUTO_INCREMENT,
    shipment_date timestamp,
    shipment_mode VARCHAR(20),
    shipment_cost float,
    order_id int,
    row_no int,
    FOREIGN KEY(order_id) REFERENCES order_table(order_id) ON DELETE CASCADE
);

CREATE TABLE payment(
    payment_id int PRIMARY KEY AUTO_INCREMENT,
    payment_quantity int,
    payment_sales int,
    payment_profit int,
    order_id int,
    customer_id int,
    row_no int,
    FOREIGN KEY(order_id) REFERENCES order_table(order_id) ON DELETE CASCADE,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);