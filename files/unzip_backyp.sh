#! /bin/bash
path=$1
jenkins_build=$2
output=$3
filename=`cat /$output/$2`
date=`date +"%m/%d/%y %H:%M:%S"`
/usr/bin/unzip -od $path $output/$filename

#check_file=`cat $path/$filename | grep 'Last Modified'`
#check=`echo $?`
#if [ $check != '0' ]
#then
	#replace before line
#	awk '/<\/BODY>/ { print "   <P>Last Modified: " date "</P>"}1' date="$date"  $output/$filename > $output/awk_tmp ; cat $output/awk_tmp > $output/$filename; rm -f $output/awk_tmp
#else
	#replace string
#	sed -i "s|<P>Last Modified.*</P>|<P>Last Modified:$date</P>|g" $path/$filename
#fi
