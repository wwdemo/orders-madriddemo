/*globals cloudantService:true */
/*eslint-env node */
var express = require('express');
var bodyParser = require('body-parser');
var cfenv = require("cfenv");
var path = require('path');
var cors = require('cors');
var appEnv = cfenv.getAppEnv();

//Setup Cloudant Service.
//cloudantService = appEnv.getService("myMicroservicesCloudant");

//Setup middleware.
var app = express();
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'www')));

//REST HTTP Methods
var orders = require('./routes/orders');
app.get('/orders', orders.list);
//app.get('/orders/:id', orders.find);
app.post('/orders', orders.create);

app.listen(8080, appEnv.bind);
console.log('App started on ' + appEnv.bind + ':' + 8080);

