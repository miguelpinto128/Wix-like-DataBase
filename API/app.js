var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var quotesRouter = require('./routes/quotes');
var usersRouter = require('./routes/users');
var websitesRouter = require('./routes/websites');
var componentsRouter = require('./routes/generateComponents');
var templateRouter = require('./routes/template');
var configsitesRouter = require('./routes/configsites');




var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/quotes', quotesRouter);
app.use('/users', usersRouter);
app.use('/websites', websitesRouter);
app.use('/comp', componentsRouter);
app.use('/template', templateRouter);
app.use('/configsites', configsitesRouter);






module.exports = app;
