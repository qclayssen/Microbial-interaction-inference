#!/usr/bin/env bash

source activate bioinfo

#This generates an SBML file with a community where each organism is assigned to its own compartment and a common community biomass equation is also generated. You can import the merged model into any simulation tool, just as any normal constraint-based model and apply different types of simulation methods (FBA, FVA, etc…).

#You can choose not to create a community biomass equation (this allows each species to grow at a different rate):
# By default, all organisms share the same extracellular environment. This is the most simple representation of the community, but also makes it more difficult to observe inter-species exchanges. Another option is to keep individual extracellular environments for each organism, and create a common metabolite pool for exchanges between these environments. The simulation results are the same (this just adds redundancy to the model) but makes it easier to analyse species-to-species exchanges:



#Pipeline du sh:
#recup tout les xml.gz d'un dossier (pour test, toutes les bacteries commençant par une lettre)
#récursivement recupérer tous les noms de fichier
#cp de ces fichiers dans un dossier random
#gunzip *
#merge-community dans ce dossier, pipe cp dans le dossier FBA
# run script FBA avec le nom du fichier en argument.

if [[ `mkdir ../../all_xml_gz` ]]; then
	cp -v ../../embl_gems/models/*/*/* ../../all_xml_gz
	gunzip -v ../../all_xml_gz/*.xml.gz
	rm -v ../../all_xml_gz/*.gz
	list_dir="a"
fi
mkdir ./merged_community/
while read line 
do 
        echo $line | cut -f 1 -d "," > first_bacteria
        echo $line | cut -f 2 -d "," > second_bacteria
        bacteria1=`cat first_bacteria`
        bacteria2=`cat second_bacteria`
        cd ../../all_xml_gz/
        ls > list_file
        grep -i -m 1 ${bacteria1} list_file > grep1
       	grep -i -m 1 ${bacteria2} list_file > grep2
        var_grep1=`cat grep1`
        var_grep2=`cat grep2`
        echo $var_grep1 
        echo $var_grep2 
		merge_community  $var_grep1 $var_grep2 --no-community-biomass --split-pool --fbc2 -o ../interaction_microbiote/FBA/merged_community/${bacteria1}_${bacteria2}.xml >> log_merge.txt
		cd ../interaction_microbiote/FBA/
		#cat ${bacteria1}_${bacteria2}.xml >> list_community.txt
done < "../FlashWeave/data_flashweave/edge_list.csv"

