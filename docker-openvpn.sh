#!/bin/bash

read -p "OVPN Container name (ovpn-data-vol): " OVPN_DATA
[ -z "$OVPN_DATA" ] && OVPN_DATA=ovpn-data-vol

docker volume create --name $OVPN_DATA

read -p "OVPN Port (1194): " OVPN_PORT
[ -z "$OVPN_PORT" ] && OVPN_PORT=1194

read -p "OVPN Server IP (localhost): " OVPN_IP
[ -z "$OVPN_IP" ] && OVPN_IP=localhost

read -p "OVPN User (client): " OVPN_USER
[ -z "$OVPN_USER" ] && OVPN_USER=client

docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://$OVPN_IP:$OVPN_PORT

docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

docker run -v $OVPN_DATA:/etc/openvpn -d -p $OVPN_PORT:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

docker run -v $OVPN_DATA:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $OVPN_USER nopass

docker run -v $OVPN_DATA:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $OVPN_USER > $OVPN_USER.ovpn
