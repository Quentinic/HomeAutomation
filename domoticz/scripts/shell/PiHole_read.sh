#!/bin/bash

# Settings
PIHOLE_IP="192.168.xxx.yyy"  # PiHole IP
PIHOLE_PORT="port" # Pi-Hole Port
DOMO_IP="192.168.xxx.zzz"    # Domoticz IP
DOMO_PORT="8080" 	  # Domoticz port
DOMAINSBLOCKED_IDX='id1'
DNSQUERIESTODAY_IDX='id2'
ADSBLOCKEDTODAY_IDX='id3'
ADSPERCENTTODAY_IDX='id4'
UNIQUEDOMAINS_IDX='id5'
QUERIESFORWARDED_IDX='id6'

# Get data from Pi_Hole API
INPUT=$(curl "http://$PIHOLE_IP:$PIHOLE_PORT/admin/api.php")
DOMAINSBLOCKED=$(echo "$INPUT" | awk -v FS="(:|,)" '{print $2}')
DNSQUERIESTODAY=$(echo "$INPUT" | awk -v FS="(:|,)" '{print $4}')
ADSBLOCKEDTODAY=$(echo "$INPUT" | awk -v FS="(:|,)" '{print $6}')
ADSPERCENTTODAY=$(echo "$INPUT" | awk -v FS="(:|,)" '{print $8}')
UNIQUEDOMAINS=$(echo "$INPUT" | awk -v FS="(:|,)" '{print $10}')
QUERIESFORWARDED=$(echo "$INPUT" | awk -v FS="(:|,)" '{print $12}')

# Make data more readable
DOMAINSBLOCKED=$(printf "%'d" "$DOMAINSBLOCKED")
DNSQUERIESTODAY=$(printf "%'d" "$DNSQUERIESTODAY")
ADSBLOCKEDTODAY=$(printf "%'d" "$ADSBLOCKEDTODAY")
UNIQUEDOMAINS=$(printf "%'d" "$UNIQUEDOMAINS")
QUERIESFORWARDED=$(printf "%'d" "$QUERIESFORWARDED")

# Load data in domoticz
curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$DOMAINSBLOCKED_IDX&nvalue=0&svalue=$DOMAINSBLOCKED"
curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$DNSQUERIESTODAY_IDX&nvalue=0&svalue=$DNSQUERIESTODAY"
curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$ADSBLOCKEDTODAY_IDX&nvalue=0&svalue=$ADSBLOCKEDTODAY"
curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$ADSPERCENTTODAY_IDX&nvalue=0&svalue=$ADSPERCENTTODAY"
curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$UNIQUEDOMAINS_IDX&nvalue=0&svalue=$UNIQUEDOMAINS"
curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$QUERIESFORWARDED_IDX&nvalue=0&svalue=$QUERIESFORWARDED"