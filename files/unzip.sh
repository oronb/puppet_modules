#! /bin/bash
path=$1
jenkins_build=$2
output=$3
filename=`cat /$output/$2`
variable=$4
#date=`date +"%m/%d/%y %H:%M:%S"`
/usr/bin/unzip -od $path $output/$filename
#for i in `seq 5 $#`;
#do
#	let i=$i+1
#	a="\$$i"
	awk '/<\/BODY>/ { print "   <P>" v "</P>"}1' variable="$variable"  $output/$filename > $output/awk_tmp 
#	cat $output/awk_tmp > $output/$filename; rm -f $output/awk_tmp
#done

#replace string
#sed -i "s|<P>Last Modified.*</P>|<P>Last Modified:$date</P>|g" $path/$filename
