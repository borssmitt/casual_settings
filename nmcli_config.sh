#!/bin/bash

#Check presens of args

if [ "$#" -ne 4 ]; then
	echo "Using: $0 <connection name> <static ip> <gateway> <DNS>"
	exit 1
fi

#Adding new args

CONNECTION_NAME="$1"
STATIC_IP="$2"
GATEWAY="$3"
DNS_SERVER="$4"

#Enable conections show

echo "Enable connection: "
nmcli connection show

#Set static IPaddress

echo "Setting static IPaddress for connection $CONNECTION_NAME..."
nmcli connection modify "$CONNECTION_NAME" ipv4.addresses "$STATIC_IP"
nmcli connection modify "$CONNECTION_NAME" ipv4.gateway "$GATEWAY"
nmcli connection modify "$CONNECTION_NAME" ipv4.dns "$DNS_SERVER"
nmcli connection modify "$CONNECTION_NAME" ipv4.method manual

#Changes apply

echo "Connection restart "$CONNECTION_NAME"

nmcli connection down "$CONNECTION_NAME" && nmcli connection up "$CONNECTION_NAME"

#Checing
echo "New configuration for "$CONNECTION_NAME:"
nmcli connection show "$CONNECTION_NAME" | grep "ipv4"
