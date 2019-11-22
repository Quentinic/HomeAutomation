#!/usr/bin/python3
import sys
from miio.chuangmi_plug import ChuangmiPlug

device_ip="192.168.xxx.yyy"
device_token="device token here"

action = str(sys.argv[1])

device = ChuangmiPlug(ip=device_ip, token=device_token)

status = device.status()
#print('current status: %s'%(status))
#print(current_status.is_on)

if action == 'on':
    if status.is_on:
        print('Device already on.')
    else:
        print('Switch device on.')
        device.on()
elif action == 'off':
    if not status.is_on:
        print('Device already off.')
    else:
        print('Switch device off.')
        device.off()
elif action == 'status':
#    print "on" if status.is_on else "off"
    print(status)