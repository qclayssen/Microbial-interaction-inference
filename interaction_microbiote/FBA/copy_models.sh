#!/usr/bin/env bash
#  Purge old files
rm -rf merged_community
rmdir merged_community
# Create a new dir
mkdir ./merged_community/
#  For every bacterias in file passed in argument
while read line
do
    # Save current line
    bacteria1=`echo $line`
    # Go in folder holding all carveme models
    cd ../../all_xml_gz/
    # Get list of all files in all_xml_gz
    ls > list_file
    # Search for files of bacterias
    grep -i -m 1 ${bacteria1} list_file > grep1
    var_grep1=`cat grep1`
    echo $var_grep1
    # Copy it
    cp ${var_grep1} ../interaction_microbiote/FBA/merged_community/${bacteria1}.xml
	cd ../interaction_microbiote/FBA/
done < $1
#  Create list community computed
cd merged_community
ls > list_community.txt
mv list_community.txt ../list_community.txt
