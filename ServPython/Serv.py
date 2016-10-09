import socket
import sys
import select

class Serv():
    port = 1000
    client = []
    data = "isConnect\n"
    def __init__(self):
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server_address = ('localhost', self.port)
        print >> sys.stderr, 'starting up on %s port %s' % server_address
        sock.bind(server_address)
        sock.listen(2)
        setattr(self, "sock", sock)
        setattr(self, "read_list", [sock])
        self.sock.setblocking(0)
    def ConnectionAndSend(self):
        while (True):      
            readable, writable, errored = select.select(self.read_list, [], [])
            for s in readable:
                if s is self.sock:
                    client_socket, address = self.sock.accept()
                    self.read_list.append(client_socket)
                    print "Connection from", address
                    client_socket.send(self.data)
                else:
                    data = s.recv(1024)
                    if data:
                        s.send(data)
                    else:
                        s.close()
                        self.read_list.remove(s)
            for c in self.read_list:
                if (c != self.sock):
                    print ("bla")
                    c.send(self.data)
        print("de")
                    
Serv = Serv()
print(Serv.sock)
Serv.ConnectionAndSend()