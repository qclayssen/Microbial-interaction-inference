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
	      cp ${var_grep1} ../interaction_microbiote/FBA/merged_community/${bacteria1}.xml
        cp ${var_grep2} ../interaction_microbiote/FBA/merged_community/${bacteria2}.xml
		    cd ../interaction_microbiote/FBA/
		    #cat ${bacteria1}.xml >> list_community.txt
done < "../FlashWeave/data_flashweave/edge_list_small.csv"
