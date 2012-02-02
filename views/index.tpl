<!DOCTYPE HTML>
<html>
  <head>
    <title>Flask/Gevent WebSocket Test</title>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.4.2.min.js"></script>
    <script>
      $(document).ready(function() {
        $('form').submit(function(event) {

          // Send data over websocket
          ws.send($('#data').val());
          return false;

        });
        if ("WebSocket" in window) {

          // Connect to websocket
          var ws = new WebSocket("ws://127.0.0.1/ws");

          // Connection established
          ws.onopen = function() {
            alert("A websocket has been opened.  Try sending some data.");
          };

          // Datapacket received
          ws.onmessage = function (evt) {
            var msg = evt.data;
            alert('Server Echo: ' + msg);
          };

          // Connection closed
          ws.onclose = function() {
            alert("A websocket has been closed.");
          };

        } else {

          // Not supported check.
          alert("WebSockets are not supported by your browser.");

        }
      });
    </script>
  </head>
  <body>
    <h1>Send Data:</h1>
    <form method='POST' action='#'>
      <textarea name='data' id="data"></textarea>
      <div><input type='submit'></div>
    </form>
  </body>
</html>

