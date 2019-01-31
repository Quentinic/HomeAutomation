#!/usr/bin/python
# -*- coding: UTF-8 -*-

import paramiko
import urllib2
import re

#domoticz server ip
domoticzserver = "127.0.0.1:8080"
#device idx
idx = ""

def domoticzrequest (url):
	request = urllib2.Request(url)
	response = urllib2.urlopen(request)
	return response.read()


ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())

#router ip
ssh.connect(hostname='192.168.x.x', port=xx, username='', password='')
cmd = 'cat /proc/dmu/temperature'
stdin, stdout, stderr = ssh.exec_command(cmd)
result = stdout.read()
temp = re.findall(u'(\d+)',result)

domoticzrequest("http://" + domoticzserver + "/json.htm?type=command&param=udevice&idx=" + idx + "&nvalue=0&svalue=" + temp[0])
