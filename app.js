const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const mustacheExpress = require('mustache-express');

const app = express();
const port = 3000;

app.engine('html', mustacheExpress());
app.set('view engine', 'html');
app.set('views', './html-template');
app.use(bodyParser.urlencoded({ extended: true }));

var dbcon = mysql.createConnection({
    host: 'localhost',
    user: 'lavender',
    password: 'gardentulip',
    database: 'sales_order_data'
})

function templateRenderer(template, res) {
    return function (error, results, fields) {
        if (error)
            throw error;

        res.render(template, { data: results });
    }
}


app.get('/', function (req, res) {
    res.render('index.html')
})

app.get('/customer', function (req, res) {
    dbcon.query("SELECT * FROM customers LIMIT 25;", templateRenderer('customers', res));
})

app.get('/orders', function (req, res) {
    dbcon.query("SELECT * FROM order_table LIMIT 25;", templateRenderer('orders', res));
})

app.get('/payment', function (req, res) {
    dbcon.query("SELECT * FROM payment LIMIT 25;", templateRenderer('payment', res));
})

app.get('/product', function (req, res) {
    dbcon.query("SELECT * FROM product LIMIT 25;", templateRenderer('product', res));
})

app.get('/shipment', function (req, res) {
    dbcon.query("SELECT * FROM shipment LIMIT 25;", templateRenderer('shipment', res));
})
app.get("/analysis", function (req, res) {
    var sqlquery = "SELECT shipment_mode,SUM(payment_profit)\
    FROM shipment\
    LEFT JOIN payment\
    ON shipment.row_no=payment.row_no\
    GROUP BY shipment_mode;";

    dbcon.query(sqlquery, function (err, analysis_results) {
        if (err) {
            res.redirect("/");
        }
        res.render("analysis", { topanalysis: analysis_results});
    });
})

app.get("/analysistwo", function (req, res) {
    var sqlquery = "SELECT product_market,SUM(payment_profit)\
    FROM product\
    LEFT JOIN payment\
    ON product.row_no=payment.row_no\
    GROUP BY product_market;";

    dbcon.query(sqlquery, function (err, analysis_results) {
        if (err) {
            res.redirect("/");
        }
        res.render("analysistwo", { topanalysis: analysis_results });
    });
})

app.get("/analysisthree", function (req, res) {

    var sqlquery = "SELECT customer_country,SUM(payment_sales)\
    FROM customers\
    LEFT JOIN payment\
    ON customers.row_no=payment.row_no\
    GROUP BY customer_country;";

    dbcon.query(sqlquery, function (err, analysis_results) {
        if (err) {
            res.redirect("/");
        }
        res.render("analysisthree", { topanalysis: analysis_results });
    });
})

    app.listen(port, function () {
        console.log('The app is listening at http://localhost:' + port + '.');
    });