#!/bin/bash
echo "Species,A10,A11,A12,A5,A6,A7,A8,A9,B10,B11,B12,B1,B2,B3,B4,B5,B6,B7,B8,B9,C10,C11,C12,C1,C2,C3,C4,C5,C6,C7,C9,D10,D11,D12,D1" > ./dataset/new_pre_data.csv
grep -v "Reads,7518904" ./dataset/SpeciesTable_HD.csv | grep -v "Species" | grep -v "Reads (million)" | grep -v "Salinibacter_ruber,0.92,0.28,0.40" | sort | uniq >> ./dataset/new_pre_data.csv
sed '/SpeciesTable_HD.csv:/d' ./dataset/new_pre_data.csv > ./dataset/new_data.csv
tr "[A-Z]" "[a-z]" < ./dataset/new_data.csv > ./dataset/new_data_lower.csv
rm ./dataset/new_pre_data.csv
rm ./dataset/new_data.csv
