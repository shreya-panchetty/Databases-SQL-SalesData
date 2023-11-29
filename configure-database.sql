DROP DATABASE IF EXISTS sales_order_data;
CREATE DATABASE sales_order_data;

USE sales_order_data;

DROP USER IF EXISTS 'lavender'@'%';
CREATE USER 'lavender'@'%' IDENTIFIED WITH mysql_native_password BY 'gardentulip'; 
GRANT ALL ON sales_order_data.* TO 'lavender'@'%';
