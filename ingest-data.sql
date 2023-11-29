USE sales_order_data;

DROP TABLE IF EXISTS dnorm_data;

CREATE TABLE dnorm_data AS(
    SELECT orderdate,
           shipdate,
           shipmode,
           customername,
           segment,
           country,
           market,
           category,
           productname,
           sales,
           quantity,
           profit,
           shippingcost,
           row_no
    FROM primary_data);

DELETE FROM customers;

INSERT INTO customers (customer_name,customer_segment,customer_country,row_no) 
    SELECT DISTINCT customername,segment,country,row_no
    FROM dnorm_data;

DELETE FROM product;

INSERT INTO product(product_name,product_category,product_market,row_no) 
    SELECT DISTINCT productname,category,market,row_no
    FROM dnorm_data;

DELETE FROM order_table;

INSERT INTO order_table(order_date,customer_id,product_id,row_no)
    SELECT o.orderdate,c.customer_id,p.product_id,o.row_no
    FROM  dnorm_data o
    JOIN customers c
    ON (o.row_no=c.row_no)
    JOIN product p 
    ON (o.row_no = p.row_no);

DELETE FROM shipment;

INSERT INTO shipment(shipment_date,shipment_mode,shipment_cost,order_id,row_no)
    SELECT s.shipdate,s.shipmode,s.shippingcost,o.order_id,s.row_no
    FROM dnorm_data s
    JOIN order_table o
    ON(s.row_no=o.row_no);

DELETE FROM payment;

INSERT INTO payment(payment_quantity,payment_sales,payment_profit,order_id,customer_id,row_no)
    SELECT pa.quantity,pa.sales,pa.profit,o.order_id,c.customer_id,pa.row_no
    FROM dnorm_data pa
    LEFT JOIN order_table o
    ON(pa.row_no=o.row_no)
    JOIN customers c
    ON(pa.row_no= c.row_no);
