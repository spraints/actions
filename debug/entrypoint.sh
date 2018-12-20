#!/bin/bash

exec 2>&1
set -x

printf '>> %s <<\n' "$@"
env
pwd
find /github -type d -ls
