#!/bin/bash

tag=$(cat build.tag)

bootc switch --transport=containers-storage localhost/silverblue:${tag} --enforce-container-sigpolicy
