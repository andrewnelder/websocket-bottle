from geventwebsocket.handler import WebSocketHandler
from gevent.pywsgi import WSGIServer
from bottle import route, Bottle, view, request

app = Bottle()


@app.route('/')
@view('index')
def index():
    return {}


@app.route('/ws')
def api():
    if request.environ.get('wsgi.websocket'):
        ws = request.environ['wsgi.websocket']
        try:
            while True:
                message = ws.receive()
                if not message:
                    break
                ws.send(message)
            ws.close()
        except geventwebsocket.WebSocketError, ex:
            print '%s: %s' % (ex.__class__.__name__, ex)

if __name__ == '__main__':
    http_server = WSGIServer(('127.0.0.1', 80), app, \
            handler_class=WebSocketHandler)
    http_server.serve_forever()
