/*const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');

const PORT = process.env.PORT || 3000;

const app = express();

app.use(cors());
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(morgan('dev'));

app.use('public', express.static(__dirname + '\\public'));

app.use(require('./routes'));

app.listen(PORT, () => {
    console.log('Server is running on localhost:', PORT);
});*/


const express = require('express');
const bodyParser = require('body-parser');
const ws = require('ws');
const cors = require('cors');
const morgan = require('morgan');
const onConnection = require('./routes/api/notification').onConnection;
const verifyWebSocketConnection = require('./modules/user-verification').verifyWebSocketConnection;

const fileUpload = require('express-fileupload');
const _ = require('lodash');

const PORT = process.env.PORT || 3000;

const auth = require('./routes/api/auth');
const api = require('./routes/api/api');
const admin = require('./routes/api/admin');
const teacher = require('./routes/api/teacher');
const student = require('./routes/api/student');
const notification = require('./routes/api/notification');


const app = express();

app.use(fileUpload({
    createParentPath: true
}));

app.use(cors());

app.use(function (request, response, next) {
    response.setHeader('Access-Control-Allow-Origin', '*');
    response.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');
    response.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');
    next();
});

app.use('/profile-pictures', express.static(__dirname + '\\profile-pictures'));
app.use('/request-documents', express.static(__dirname + '\\request-documents'));


app.use(bodyParser.json({limit: '16mb'}));

app.use(bodyParser.urlencoded({
    extended: true
}));

app.use(morgan('dev'));

app.use('/auth', auth);
app.use('/api', api);
app.use('/admin', admin);
app.use('/teacher', teacher);
app.use('/student', student);
app.use('/notification',notification);

app.get('/', function (request, response) {
    response.writeHead(200, {'Content-Type': 'text/html'});
    response.write('Hello from the server!');
    response.end();
});

const wsServer = new ws.Server({server: app});
wsServer.on('connection', socket=> {
    onConnection(socket, wsServer);
});

const server = app.listen(PORT, () => {
    console.log('Server is running on localhost:', PORT)
});

server.on('upgrade', (request, socket, head) => {
    verifyWebSocketConnection(request, socket, head, wsServer).then(message => {
        if (message) console.log(message);
    });
});

