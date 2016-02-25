#! /bin/bash
url=$1
repository=$2
output=$3
user=$4
password=$5
jenkins_build=$6
artifact_type=$7
filename=`cat /$output/$6`
apache_path=$8
echo "/usr/bin/curl -sS -f -L $url/$repository/$filename -o $output/$filename -u $user:$password -v --location-trusted"
/usr/bin/curl -sS -f -L $url/$repository/$filename -o $output/$filename -u $user:$password -v --location-trusted
#if [ $artifact_type == 'zip' ]
#then
#	/usr/bin/unzip -od ${apache_path} ${output}/${filename}.erb
#fi
