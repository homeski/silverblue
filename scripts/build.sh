#!/bin/bash

podman pull ghcr.io/wayblueorg/sway-nvidia-gdm:43

tag=$(date +%y%m%d%M)

podman build . -t silverblue:${tag}

echo ${tag} > build.tag
