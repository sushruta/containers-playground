#!/bin/bash

SSH_KEY_PATH=$HOME/.imported_ssh_keys
mkdir $HOME/.ssh && cat $SSH_KEY_PATH/id_rsa_key.pub > $HOME/.ssh/authorized_keys
chmod 644 -R $HOME/.ssh

exec /usr/sbin/sshd -D
