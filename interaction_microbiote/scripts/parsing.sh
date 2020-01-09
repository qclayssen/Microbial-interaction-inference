#!/bin/bash

ls ../all_xml_gz > ./dataset/species_carveme.txt
#sed '/\//d' species_carveme.txt |sed '/^$/d' | sed 's/\([a-z]*_[a-z]*\)_.*/\1/g' >> liste_species_carveme.txt
cut -f 1 -d "," ./dataset/new_data_lower.csv > ./dataset/liste_species_dataset.txt
tr "[A-Z]" "[a-z]" < ./dataset/species_carveme.txt > ./dataset/liste_species_carveme_lower.txt
tr "[A-Z]" "[a-z]" < ./dataset/liste_species_dataset.txt > ./dataset/liste_species_dataset_lower.txt
sed '/\//d' ./dataset/liste_species_carveme_lower.txt | sed '/^$/d' | sed 's/\([a-z]*_[a-z]*\).*/\1/g' > ./dataset/liste_species_carveme_parse.txt

rm ./dataset/TEMP.txt
liste_species_carveme=`ls ../all_xml_gz`
for species in $liste_species_carveme
do
  basename -s .xml $species | sed 's/\([a-z]*_[a-z]*\).*/\1/g' >> ./dataset/TEMP.txt
done
echo "BEGINNING OF THE GREP IN LIST SPECIES CARVEME PARSE"

liste_species_match=`cat ./dataset/TEMP.txt`
echo $liste_species_match
echo "................................"
rm ./dataset/data_match_carveme.txt
buffer_file=`cat ./dataset/new_data_lower.csv`
echo $buffer_file
COUNT=0
for match in $liste_species_match
do
  echo $match
  echo "$buffer_file" | grep -i "^${match}.[a-z]*" >> ./dataset/data_match_carveme.txt
  echo "$COUNT"
  COUNT=$[COUNT+1]
done
#echo "$buffer_res" > data_match_carveme.txt
rm ./dataset/TEMP.txt
rm ./dataset/new_data_match.csv
head -n1 ./dataset/new_data_lower.csv >> ./dataset/new_data_match.csv
sort ./dataset/data_match_carveme.txt | uniq >> ./dataset/new_data_match.csv
