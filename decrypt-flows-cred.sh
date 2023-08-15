#!/bin/bash
#
# Description:
#     Decrypt flows_cred.json from the specified directory. You will be prompted for the decryption password.
#
# Usage:
#     ./decrypt-flows-cred.sh {path to cred file, if PWD use '.'}
#
# Changelog:
#     2023-08-14: Fetched script from original source <https://blog.hugopoi.net/en/2021/12/28/how-to-decrypt-flows_cred-json-from-nodered-data/>
#                 Credit to the original author/creator.
#     2023-08-14: Adjusted to prompt for password when running command.
#     2023-08-14: Adjusted to output to a file called 'flows_cred.json.tmp'
#

echo -n "Please enter the flows_cred.json decryption key: ";
read -s PASSWORD
echo;

DecryptedData=$(jq  '.["$"]' -j $1/flows_cred.json | \
  cut -c 33- | \
  openssl enc -aes-256-ctr -d -base64 -A -iv `jq  -r '.["$"]' $1/flows_cred.json | cut -c 1-32` -K `echo -n $PASSWORD | sha256sum | cut -c 1-64`)

echo -n $DecryptedData > $1/flows_cred.json.tmp
#echo -n $DecryptedData
