#!/bin/bash
set -xe

HOST_SSH_KEY_PATH="$HOME/.docker_ssh_keys"
CONTAINER_SSH_KEY_PATH="/root/.imported_ssh_keys"

CONTAINER_SSH_PORT=22
HOST_SSH_PORT=22222

base_image="github.com/sushruta/infra/sshd"
label="latest"
container_name="sshd-container"

function script_usage() {
  echo "Run an sshd container specifying the image and label you want"
  echo ""
  echo "cmd arguments (all are optional) --"
  echo "-h | --help :: this help message"
  echo "-i | --image :: container image to run"
  echo "-l | --label :: git hash of the container image"
  echo "-n | --name :: name you want to give to the container"
  echo "-p | --port :: port you want to bind the host machine to"
  echo ""
}

while [ "$1" != "" ]; do
  $PARAM_KEY=`echo $1 | awk -F= '{print $1}'`
  $PARAM_VALUE=`echo $1 | awk -F= '{print $2}'`
  case $PARAM_KEY in
    -h | --help)
      script_usage
      exit
      ;;
    -i | --image)
      base_image=$PARAM_VALUE
      ;;
    -n | --name)
      container_name=$PARAM_VALUE
      ;;
    -p | --port)
      host_port=$PARAM_VALUE
      ;;
    -l | --label)
      label=$PARAM_VALUE
      ;;
    *)
      echo "ERROR: unknown parameter `$PARAM_KEY`"
      script_usage
      exit
      ;;
  esac
  shift
done

## stop the script if it is already running
docker rm -f ${container_name} || true

## run the container
docker run -d -v $HOST_SSH_KEY_PATH:$CONTAINER_SSH_KEY_PATH -p $HOST_SSH_PORT:$CONTAINER_SSH_PORT --name ${container_name} ${base_image}:ubuntu-16.04-${label}
