from Queue import Queue
from threading import Thread
from serv import Serv

def listener(server,q):
    server.listen(q)

def sender(server, q):
    while True:
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

#q = Queue()
#s = Serv()
#q.put("hello")
#q.put("world")
#t1 = Thread(target=listener, args=(s,))
#t2 = Thread(target=sender, args=(s,q,))
#t1.start()
#t2.start()

