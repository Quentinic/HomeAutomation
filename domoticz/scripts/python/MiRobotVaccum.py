#!/usr/bin/python

import socket
import sys
import codecs

UDP_IP = '192.168.xxx.yyy'
UDP_PORT = 54321
INET_ADDR = (UDP_IP,UDP_PORT)

action = str(sys.argv[1])
massage = "2130000000000000000000000" # same prefix

if action == "start":
   message_to_send = massage + "xxxxxxxxxxxxxxxxx"

if action == "pause":
   message_to_send = massage + "yyyyyyyyyyyyyyyy"

if action == "home":
   message_to_send = massage + "zzzzzzzzzzzzzzzz"

if action == "find":
   message_to_send = massage + "xxxxxxyyyyyyzzzz"

message_to_send = codecs.decode(message_to_send, "hex_codec")
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.sendto(message_to_send, INET_ADDR)