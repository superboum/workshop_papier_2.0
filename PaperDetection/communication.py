from Queue import Queue
from threading import Thread
from serv import Serv

def listener(server):
    server.listen()

def sender(server, q):
    while True:
        server.send(q.get())

class Communication():
    queue, serv, listener, sender = (None,)*4

    def __init__(self):
        self.queue = Queue()
        self.serv = Serv()
        self.listener = Thread(target=listener, args=(self.serv,))
        self.sender = Thread(target=sender, args=(self.serv, self.queue,))

    def start(self):
        self.listener.start()
        self.sender.start()

    def send(self, message):
        self.queue.put(message)

#q = Queue()
#s = Serv()
#q.put("hello")
#q.put("world")
#t1 = Thread(target=listener, args=(s,))
#t2 = Thread(target=sender, args=(s,q,))
#t1.start()
#t2.start()

