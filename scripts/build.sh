#!/bin/bash

podman build . -t silverblue:$(date +%y%m%d)
