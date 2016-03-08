#! /bin/bash
set -e
path=$1
jenkins_build=$2
output=$3
filename=`cat /$output/$2`
variable=$4

/usr/bin/unzip -od $path $output/$filename

