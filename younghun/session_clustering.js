var express = require('express');
var app = express();

var session = require('express-session');
var RedisStore = require('connect-redis')(session);

var Redis = require('ioredis');
var redisClient = new Redis({port: 6379, host: ''});

app.use(session({
    secret: 'redis-session-test',
    store: new RedisStore({client: redisClient}),
    resave: false,
    saveUninitialized: true
}));

app.get('/session', function (req, res) {
    var session = req.session;
    console.log(session.user);
    if (session.user) {
        res.send('session already saved. user = ' + session.user);
    } else {
        session.user = 'test';
        res.send('session saved');
    }
});

app.listen(5000, function () {
    console.log('Web Console @ 127.0.0.1: 5000');
});