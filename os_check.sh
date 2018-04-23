#!/bin/bash
#Checking OS Type
OS_version=$(awk -F= '/^NAME/{print tolower($2)}' /etc/os-release)
grep centos $OS_version || echo "$OS_version is not supported" && exit 1
