var WebSocketClient = require('websocket').client;
var client = new WebSocketClient();

client.on('connect', function(connection) {
  console.log('WebSocket Client Connected');
  connection.on('error', function(error) {
    console.log("Connection Error: " + error.toString());
  });
  connection.on('close', function() {
    console.log('echo-protocol Connection Closed');
  });
  connection.on('message', function(message) {
    if (message.type === 'utf8') {
      console.log("Received: '" + message.utf8Data + "'");
    }
  });
   
  function sendPing() {
    if (connection.connected) {
      connection.sendUTF("ping");
      //setTimeout(sendPing, 1000);
    }
  }
  sendPing();
  process.stdin.resume();
  process.stdin.setEncoding('utf8');
  var util = require('util');

  process.stdin.on('data', function (text) {
    connection.sendUTF(util.inspect(text));
    if (text === 'quit\n') {
      process.exit();
    }
  });  
});

var con = client.connect('ws://localhost:8090/_ws', "ping_protocol")

