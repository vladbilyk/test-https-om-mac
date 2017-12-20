#!/bin/bash

if [ -z "$1" ]
then
  echo "Please supply a subdomain to create a certificate for";
  echo "e.g. localhost, myapp or www.mysite.com"
  exit;
fi

if [ ! -f ./certs/ca.crt ] || [ ! -f ./certs/ca.key ];
then
  echo "Certificate Authority files are missing. Run create-ca.sh..."
  exit;
fi

# Create a new private key if one doesnt exist, or use the existing one if it does
if [ -f ./certs/private.key ]; then
  KEY_OPT="-key"
else
  KEY_OPT="-keyout"
fi

DOMAIN=$1
COMMON_NAME=$1
SUBJECT="/C=RU/ST=None/L=None/O=None/CN=$COMMON_NAME"
NUM_OF_DAYS=999
openssl req -new -newkey rsa:2048 -sha256 -nodes $KEY_OPT ./certs/private.key -subj "$SUBJECT" -out ./certs/private.csr
cat di.cfg | sed s/%%DOMAIN%%/$COMMON_NAME/g > "/tmp/$DOMAIN.di.cfg"
openssl x509 -req -in ./certs/private.csr -CA ./certs/ca.crt -CAkey ./certs/ca.key -CAcreateserial -out ./certs/private.crt -days $NUM_OF_DAYS -sha256 -extfile "/tmp/$DOMAIN.di.cfg"

# move output files to final filenames
mv ./certs/private.csr ./certs/$DOMAIN.csr
cp ./certs/private.crt ./certs/$DOMAIN.crt

# remove temp file
rm -f ./certs/private.crt;

echo
echo "###########################################################################"
echo Done!
echo "###########################################################################"
echo "To use these files on your server, simply copy both certs/$DOMAIN.csr and"
echo "certs/private.key to your webserver."
