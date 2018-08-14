#!/bin/bash
set -xe

image_tag="$(git describe --always --tags HEAD)"
base_image="github.com/sushruta/infra/sshd"

for df in Dockerfile.* ; do
  label="${df#*.}"
  docker build -t "${base_image}:${label}-${tag}" -f $df .
  docker build -t "${base_image}:${label}-latest" -f $df .
done
