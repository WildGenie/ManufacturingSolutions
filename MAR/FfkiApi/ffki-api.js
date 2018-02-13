﻿var express = require('express');
var bodyParser = require('body-parser');
var fs = require("fs");
var readDir = require("readdir");
var multer = require('multer');
//var shell = require('node-powershell');
var redis = require("redis");
var cors = require("cors");
var config = require("nodejs-config")(__dirname);
var mongoClient = require('mongodb').MongoClient;
//var mssql = require("mssql");
var Connection = require('tedious').Connection;  
var Request = require('tedious').Request
var TYPES = require('tedious').TYPES;  

var assert = require('assert');
//var bearerToken = require('express-bearer-token');
//var async = require("async");
var cluster = require('cluster');
var os = require('os');
var cpuCount = os.cpus().length;
var app = express();

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded

//for cross domain access
//app.all('*', function (req, res, next) {
//    res.header("Access-Control-Allow-Origin", "*");
//    res.header("Access-Control-Allow-Headers", "X-Requested-With,Authorization,Content-Type");
//    res.header("Access-Control-Allow-Methods", "PUT,POST,GET,DELETE,OPTIONS");
//    res.header("Content-Type", "application/json;charset=utf-8");
//    next();
//});

app.use(cors());

//app.use(bearerToken());
//app.use(function (req, res) {
//    res.send('Token ' + req.token);
//});

var httpServerPort = config.get("app.http-server-port"); //8089;
var webSocketServerPort = config.get("app.web-socket-server-port");
var redisAddress = config.get("app.redis-address"); //"127.0.0.1";
var redisPort = config.get("app.redis-port"); //6379;
var redisPassword = config.get("app.redis-password"); //"P@ssword1";
var redisDbIndex = config.get("app.redis-db-index"); //0;
var redisDbIndexClientStatus = config.get("app.redis-db-index-client-status"); //0;
var mongoDBUrl = config.get("app.mongodb-url");
var mongoDBCollectionName = config.get("app.mongodb-collection-name");
var mssqlConnectionString = config.get("app.mssql-connection-string");
var mssqlConnectionConfig = config.get("app.mssql-connection-config");
var oa3ReportXmlRepository = config.get("app.report-xml-repository");
var logRepository = config.get("app.log-repository");

var oa3ReportXmlUploader = multer({
    storage: multer.diskStorage({
        destination: function (req, file, cb) {
            cb(null, oa3ReportXmlRepository);
        },
        filename: function (req, file, cb) {
            cb(null, Date.now().toString() + "_" + file.originalname);
        }
    })
}).any();

var logUploader = multer({
    storage: multer.diskStorage({
        destination: function (req, file, cb) {
            cb(null, logRepository);
        },
        filename: function (req, file, cb) {
            cb(null, req.params.trsnid + "_" + file.originalname);
        }
    })
}).any();

var http = require('http').Server(app);
var io = require('socket.io')(http);

//if (cluster.isMaster) {

//    console.log(`Master ${process.pid} is running`);

//    console.log(`Number of CPUs: ${cpuCount}.`);

//    for (var i = 0; i < cpuCount; i++) {
//        cluster.fork();
//    }

//    cluster.on('exit', (worker, code, signal) => {
//        console.log(`worker ${worker.process.pid} died`);
//    });
//}
//else {

//    var server = app.listen(httpServerPort, function () {
//        var host = server.address().address;
//        var port = server.address().port;
//        console.log("OA3.0 FFKI RESTful API service listening at http://%s:%s", host, port);
//    });

//    http.listen(webSocketServerPort, function () {
//        console.log("Web Socket server is running, listening on port \"" + webSocketServerPort + "\"...");
//    });

//    console.log(`Worker ${process.pid} started`);
//}

var server = app.listen(httpServerPort, function () {
    var host = server.address().address;
    var port = server.address().port;
    console.log("OA3.0 FFKI RESTful API service listening at http://%s:%s", host, port);
})

http.listen(webSocketServerPort, function () {
    console.log("Web Socket server is running, listening on port \"" + webSocketServerPort + "\"...");
});

io.on("connection", function (socket) {
    console.log("A new app connected!");

    socket.on("msg:newdata", function (data) {
        //persistData(data);
        //io.emit("msg:msgrly", data);
        //io.emit("msg:resp", "OK! " + Date.now().toString());
    });

    socket.on("msg:newmsg", function (data) {
        //persistData(data);
        io.emit("msg:msgrly", data);
    });

    //socket.on("msg:cltstat", function (data) {

    //    var ipAddress = socket.handshake.address;
    //    var clientStatus = { ip: ipAddress, status: data };

    //    updateClientStatus(status);
    //});
});


function getRedisClient() {
    var client = redis.createClient(redisPort, redisAddress);
    client.auth(redisPassword);

    return client;
}

var insertDocuments = function (db, data, callback) {
    var collection = db.collection(mongoDBCollectionName);
    collection.insertOne(
        data,
        function (err, result) {
            assert.equal(err, null);
            assert.equal(1, result.result.n);
            assert.equal(1, result.ops.length);
            console.log("OK!");
            callback(result);
        });
}

function persistData(data) {
    mongoClient.connect(mongoDBUrl, function (err, db) {
        assert.equal(null, err);
        console.log("Connected to MongoDB.");

        insertDocuments(db, data, function (res) {
            db.close();

            console.log(res);

            data.id = res.insertedId;
            console.log(JSON.stringify(data));

            //io.emit("msg:msgrly", data);
        });
    });
}

app.get('/', function (req, res) {
    res.send('Welcome to OA3.0!');
});

app.get('/oa3/business/all', function (req, res) {
    try {
        console.log(mssqlConnectionConfig);

        var sqlConn = new Connection(mssqlConnectionConfig);

        sqlConn.on('connect', function (err) { 
            if (err) {
                console.log(err);
            }
            else {
                console.log("Connected");

                request = new Request("SELECT Value.query('/CloudOAConfiguration/BusinessSettings[./CloudOABusinessSetting/IsActive=\"true\"]') AS BusinessSettings FROM Configuration WHERE Name = 'CloudOASettingVersion2'", function (err, rowCount) {
                    if (err) {
                        console.log(err);
                    }
                    else {
                        console.log(rowCount);
                    }
                });

                request.on('row', function (columns) {
                    columns.forEach(function (column) {
                        if (column.value === null) {
                            console.log('NULL');
                        } else {
                            console.log(column.value);
                            res.end(column.value);
                        }
                    });
                });

                sqlConn.execSql(request);  
            }
        });

    } catch (err) {
        console.log(err);
    }
});

app.post("/oa3/report/", function (req, res) {

    oa3ReportXmlUploader(req, res, function (err) {
        if (err) {
            console.log(err);
            res.end(err);
        }

        console.log(req.files[0].path);

        //req.file = req.files[0];
        //var tmp_path = req.file.path;
        //console.log(tmp_path);

        //var target_path = ffuImageRepository + "/" + Date.now().toString() + "_" + req.file.originalname;

        //console.log(target_path);

        //if (!fs.existsSync(ffuImageRepository)) {
        //    fs.mkdirSync(ffuImageRepository);
        //}

        //var src = fs.createReadStream(tmp_path);
        //var dest = fs.createWriteStream(target_path);

        //src.pipe(dest);

        //src.on('end', function () {
        //    res.end();
        //});

        //src.on('error', function (err) {
        //    res.end();
        //    console.log(err);
        //});

    });
});

app.post("/oa3/log/:trsnid", function (req, res) {

    logUploader(req, res, function (err) {
        if (err) {
            console.log(err);
            res.end(err);
        }

        console.log(req.params.trsnid);
        console.log(req.files[0].path);
    });
});

app.get('/wds/lookup/:key', function (req, res) {
    var redisClient = getRedisClient();
    var key = req.params.key;

    redisClient.select(redisDbIndex, function (err) {
        if (err) {
            console.log(err);
            res.end(err);
        }
        else {
            redisClient.get(key, function (err, result) {
                if (err) {
                    console.log(err);
                    res.end(err);
                }
                else {
                    console.log(result);
                    redisClient.end(true);
                    res.end(result);
                }
            });
        }
    });
});