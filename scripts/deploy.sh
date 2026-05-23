#!/bin/bash

bootc switch --transport=containers-storage localhost/silverblue:$(date +%y%m%d%M) --enforce-container-sigpolicy
