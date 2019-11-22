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

if action == 'on' and not status.is_on:
    device.on()
elif action == 'off' and status.is_on:
    device.off()
elif action == 'status':
    print(status)