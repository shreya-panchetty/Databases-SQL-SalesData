USE sales_order_data;

DROP TABLE IF EXISTS primary_data;

CREATE TABLE primary_data(
    orderdate timestamp,
    shipdate timestamp,
    shipmode varchar(32),
    customername varchar(128),
    segment varchar(30),
    country varchar(50),
    market varchar (50),
    category varchar(50),
    productname varchar(255),
    sales int,
    quantity int,
    profit float,
    shippingcost int,
    row_no int
);

LOAD DATA INFILE '/home/coder/project/mid-term/super-sales-orders/data/small-superstore-sales-data.csv'
INTO TABLE primary_data
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
