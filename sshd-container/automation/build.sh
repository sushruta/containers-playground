#!/bin/bash
set -e

image_tag="$(git describe --always --tags HEAD)"
base_image="github.com/sushruta/infra/sshd"

SSH_KEY_PATH="$HOME/.docker_ssh_keys"

## build the docker container here
for df in Dockerfile.* ; do
  label="${df#*.}"
  docker build -t "${base_image}:${label}-${image_tag}" -f $df .
  docker build -t "${base_image}:${label}-latest" -f $df .
done

echo "setting up ssh keys"

## create the location where the public key
## will be stored.
rm -f $SSH_KEY_PATH && mkdir -p $SSH_KEY_PATH

## create the ssh keys here
ssh-keygen -q -N "" -t rsa -f $SSH_KEY_PATH/id_rsa_key

## display the private key for one time
## copy-paste and storage. Delete that key
## subsequently.
echo "Please store this private key in a safe place."
echo "You need to use this key to ssh in as root"
echo "Please ssh in as 'ssh -i <private.key> root@localhost -p <port_number>'"
echo "Now the private key"
echo ""
cat $SSH_KEY_PATH/id_rsa_key && rm $SSH_KEY_PATH/id_rsa_key
echo ""

echo "Done"
