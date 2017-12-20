#!/bin/bash

echo "###########################################################################"
echo Creating Certificate Authority...
echo "###########################################################################"

openssl genrsa -out ./certs/ca.key 2048
openssl req -x509 -new -nodes -key ./certs/ca.key -sha256 -days 512 -out ./certs/ca.crt -config ca.cfg

echo "###########################################################################"
echo Done!
echo "###########################################################################"
echo "Add certs/ca.crt to the System keychain and then explicitly mark it as" 
echo "trusted."