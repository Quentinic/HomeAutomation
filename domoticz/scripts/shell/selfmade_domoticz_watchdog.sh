#!/bin/bash

output=$(sudo service domoticz status | grep 'active (running)')
echo $output
size=${#output}
echo $size

if [ $size -eq 0 ]; then
    echo "domoticz is not runing, starting it now."
    sudo service domoticz stop
    sleep 10
    sudo service domoticz start
else
    echo "domoticz is running, no need to do anything."
fi