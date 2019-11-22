#!/usr/bin/python

import broadlink
import sys

device_ip = "192.168.xxx.yyy"
device_port = 80
device_mac = "mac address"
device_type = "broadlink.sp2"

action = str(sys.argv[1])

device = broadlink.sp2(host=(device_ip,device_port), mac=bytearray.fromhex(device_mac))

device.auth()

if action == "on":
        device.set_power(True)
elif action == "off":
        device.set_power(False)
elif action == "status":
        print "on" if device.check_power() else "off"