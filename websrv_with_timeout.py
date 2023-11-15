import threading
import time
from http.server import BaseHTTPRequestHandler, HTTPServer, ThreadingHTTPServer


class HttpGetHandler(BaseHTTPRequestHandler):
    """Обработчик с реализованным методом do_GET."""
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write('<html><head><meta charset="utf-8">'.encode())
        self.wfile.write('<title>Простой HTTP-сервер.</title></head>'.encode())
        self.wfile.write('<body>Был получен GET-запрос.</body></html>'.encode())


class MyServer(threading.Thread):
    def run(self):
        self.server = ThreadingHTTPServer(('', 8000), HttpGetHandler)
        self.server.serve_forever()
    def stop(self):
        self.server.shutdown()        
        

        
if __name__ == "__main__":
    s = MyServer()
    s.start()
    print('thread alive:', s.is_alive())  # True
    time.sleep(15)
    s.stop()
    print('thread alive:', s.is_alive())  # False
