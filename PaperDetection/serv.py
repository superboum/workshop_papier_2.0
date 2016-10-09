import socket
import select
import sys

class Serv():
    sock = None
    read_list = []
    port = 5984

    def __init__(self):
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        server_address = ('0.0.0.0', self.port)
        print >> sys.stderr, 'starting up on %s port %s' % server_address
        sock.bind(server_address)
        sock.listen(2)
        setattr(self, "sock", sock)
        setattr(self, "read_list", [sock])


    def listen(self):
        while (True):      
            readable, writable, errored = select.select(self.read_list, [], [])
            for s in readable:
                if s is self.sock:
                    client_socket, address = self.sock.accept()
                    self.read_list.append(client_socket)
                    print "Connection from", address
                else:
                    data = s.recv(1024)
                    if data:
                        print data
                    else:
                        s.close()
                        self.read_list.remove(s)

    def send(self, message):
        for sock in self.read_list:
            if sock != self.sock:
                try:
                    sock.send(message)
                except:
                    sock.close()
                    self.read_list.remove(sock)
