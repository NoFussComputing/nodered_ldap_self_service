#!/bin/bash
#
# Description:
#     Encrypt flows_cred.json.tmp from the specified directory to flows_cred.json. You will be prompted for the encryption password.
#
# Usage:
#     ./encrypt-flows-cred.sh {path to cred file, if PWD use '.'}
#
# Changelog:
#     2023-08-15: Script creation.
#

echo -n "Please enter the flows_cred.json decryption key: ";
read -s PASSWORD;
echo;

Rand=$(tr -dc 'A-Fa-f0-9' </dev/urandom | head -c 32);

EncryptedData=$(cat $1/flows_cred.json.tmp | openssl enc -aes-256-ctr -e -a -A -iv $Rand -K `echo -n $PASSWORD | sha256sum | cut -c 1-64`)

cat <<EOF > $1/flows_cred.json
{
    "$": "$Rand$EncryptedData"
}
EOF

echo;

rm $1/flows_cred.json.tmp;
