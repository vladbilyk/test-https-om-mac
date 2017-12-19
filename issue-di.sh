#!/bin/bash

if [ -z "$1" ]
then
  echo "Please supply a subdomain to create a certificate for";
  echo "e.g. localhost, myapp or www.mysite.com"
  exit;
fi

if [ ! -f ca.crt ] || [ ! -f ca.key ];
then
  echo "Certificate Authority files are missing. Run create-ca.sh..."
  exit;
fi

# Create a new private key if one doesnt exist, or use the existing one if it does
if [ -f private.key ]; then
  KEY_OPT="-key"
else
  KEY_OPT="-keyout"
fi

DOMAIN=$1
COMMON_NAME=$1
SUBJECT="/C=RU/ST=None/L=None/O=None/CN=$COMMON_NAME"
NUM_OF_DAYS=999
openssl req -new -newkey rsa:2048 -sha256 -nodes $KEY_OPT private.key -subj "$SUBJECT" -out private.csr
cat di.cfg | sed s/%%DOMAIN%%/$COMMON_NAME/g > "/tmp/$DOMAIN.di.cfg"
openssl x509 -req -in private.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out private.crt -days $NUM_OF_DAYS -sha256 -extfile "/tmp/$DOMAIN.di.cfg"

# move output files to final filenames
mv private.csr $DOMAIN.csr
cp private.crt $DOMAIN.crt

# remove temp file
rm -f private.crt;

echo
echo "###########################################################################"
echo Done!
echo "###########################################################################"
echo "To use these files on your server, simply copy both $DOMAIN.csr and"
echo "private.key to your webserver."
