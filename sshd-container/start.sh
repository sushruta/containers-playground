#!/bin/bash

SSH_KEY_PATH=/root/.ssh/container_keys
cat $SSH_KEY_PATH/id_rsa_key.pub >> /root/.ssh/authorized_keys

exec /usr/sbin/sshd -D
