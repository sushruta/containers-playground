#!/bin/bash

SSH_KEY_PATH=$HOME/.ssh
cat $SSH_KEY_PATH/id_rsa_key.pub > $SSH_KEY_PATH/authorized_keys
chmod 644 $SSH_KEY_PATH/authorized_keys

exec /usr/sbin/sshd -D
