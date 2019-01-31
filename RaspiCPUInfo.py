#!/usr/bin/python

import os
import paramiko
import urllib2
import re

#domoticz server ip
domoticzserver = "127.0.0.1:8080"
#device idx
tempIdx = "84"
cpuUsageIdx = "140"
diskUsageIdx = "141"
diskStatisticsIdx = "143"

def domoticzrequest(url):
        request = urllib2.Request(url)
        response = urllib2.urlopen(request)
        return response.read()




# Return CPU temperature as a character string
def getCPUtemperature():
    res = os.popen('vcgencmd measure_temp').readline()
    return(res.replace("temp=","").replace("'C\n",""))

# Return RAM information (unit=kb) in a list
# Index 0: total RAM
# Index 1: used RAM
# Index 2: free RAM
def getRAMinfo():
    p = os.popen('free')
    i = 0
    while 1:
        i = i + 1
        line = p.readline()
        if i==2:
            return(line.split()[1:4])

# Return % of CPU used by user as a character string
def getCPUuse():
    return(str(os.popen("top -n1 | awk '/Cpu\(s\):/ {print $2}'").readline().strip()))

# Return information about disk space as a list (unit included)
# Index 0: total disk space
# Index 1: used disk space
# Index 2: remaining disk space
# Index 3: percentage of disk used
def getDiskSpace():
    p = os.popen("df -h /")
    i = 0
    while 1:
        i = i +1
        line = p.readline()
        if i==2:
            return(line.split()[1:5])


# CPU informatiom
CPU_temp = getCPUtemperature()
CPU_usage = getCPUuse()

# RAM information
# Output is in kb, here I convert it in Mb for readability
RAM_stats = getRAMinfo()
RAM_total = round(int(RAM_stats[0]) / 1000,1)
RAM_used = round(int(RAM_stats[1]) / 1000,1)
RAM_free = round(int(RAM_stats[2]) / 1000,1)

# Disk information
DISK_stats = getDiskSpace()
DISK_total = DISK_stats[0]
DISK_used = DISK_stats[1]
DISK_perc = DISK_stats[3]

domoticzrequest("http://"+domoticzserver+"/json.htm?type=command&param=udevice&idx="+tempIdx+"&nvalue=0&svalue="+CPU_temp)
domoticzrequest("http://"+domoticzserver+"/json.htm?type=command&param=udevice&idx="+cpuUsageIdx+"&nvalue=0&svalue="+CPU_usage)
DISK_percentage=re.findall("\d+", DISK_perc)[0]
domoticzrequest("http://"+domoticzserver+"/json.htm?type=command&param=udevice&idx="+diskUsageIdx+"&nvalue=0&svalue="+DISK_percentage)
DISK_statistics = str(DISK_used) + "B;" + str(DISK_total) + "B;" + str(DISK_percentage) + urllib2.quote("%")
domoticzrequest("http://"+domoticzserver+"/json.htm?type=command&param=udevice&idx="+diskStatisticsIdx+"&nvalue=0&svalue="+DISK_statistics)

#print(DISK_statistics)

#if __name__ == '__main__':
#    print('')
#    print('CPU Temperature = '+CPU_temp + ' C')
#    print('CPU Use = '+CPU_usage)
#    print('')
#    print('RAM Total = '+str(RAM_total)+' MB')
#    print('RAM Used = '+str(RAM_used)+' MB')
#    print('RAM Free = '+str(RAM_free)+' MB')
#    print('')
#    print('DISK Total Space = '+str(DISK_total)+'B')
#    print('DISK Used Space = '+str(DISK_used)+'B')
#    print('DISK Usage = '+str(DISK_perc))
#    print('DISK Used Percentage = '+str(DISK_perc))
