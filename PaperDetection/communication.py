from Queue import Queue
from threading import Thread
from serv import Serv

def listener(server,q):
    server.listen(q)

def sender(server, q):
    while server.running:
        server.send(q.get())

class Communication():
    emit_queue, receive_queue, serv, listener, sender = (None,)*5

    def __init__(self):
        self.emit_queue = Queue()
        self.receive_queue = Queue()
        self.serv = Serv()
        self.listener = Thread(target=listener, args=(self.serv, self.receive_queue,))
        self.sender = Thread(target=sender, args=(self.serv, self.emit_queue,))

    def start(self):
        self.listener.start()
        self.sender.start()

    def receive(self):
        return self.receive_queue

    def send(self, message):
        self.emit_queue.put(message)

    def terminate(self):
        self.serv.running = False
        self.emit_queue.put("BYE")
        self.serv.sock.shutdown(0)
