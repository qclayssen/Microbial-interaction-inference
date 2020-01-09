rm *.txt &
while read line
do
        echo $line | cut -f 1 -d "," > first_bacteria
        echo $line | cut -f 2 -d "," > second_bacteria
        bacteria1=`cat first_bacteria`
        bacteria2=`cat second_bacteria`
        awk '/'${bacteria1}'/{flag=1;next}/PID:/{flag=0}flag' ../output_pFBA.txt | sed '1d'| sed '1d' | sed '/^$/d'  > ${bacteria1}_fba.txt
        awk '/'${bacteria2}'/{flag=1;next}/PID:/{flag=0}flag' ../output_pFBA.txt | sed '1d'| sed '1d' | sed '/^$/d'  > ${bacteria2}_fba.txt
        awk '{print $1}' ${bacteria1}_fba.txt > bact1_in.txt
        awk '{print $1}' ${bacteria2}_fba.txt > bact2_in.txt
        awk '{print $3}' ${bacteria1}_fba.txt > bact1_out.txt
        awk '{print $3}' ${bacteria2}_fba.txt > bact2_out.txt
        bact1_in=`cat bact1_in.txt`
        listcompos1=""
        listcompos2=""
        for compos1 in $bact1_in
        do
          listcompos1+=`grep "\b${compos1}" bact2_out.txt  | tr '\n' ','`
        done
        echo -e "${bacteria1}\t${bacteria2}\t${listcompos1}" >> flux_fba_t2.tsv
        bact2_in=`cat bact2_in.txt`
        for compos2 in $bact2_in
        do
          listcompos2+=`grep "\b${compos2}" bact1_out.txt | tr '\n' ','`
        done
        echo -e "${bacteria2}\t${bacteria1}\t${listcompos2}" >> flux_fba_t2.tsv
done < "../../couple_bact.txt"
#sed 's/[P]+/,/g' flux_fba.txt > flux_fba_final.txt



bact1_in=`cat bact1_in.txt`
listcompos1=""
listcompos2=""
for compos1 in $bact1_in
do
  listcompos1+=`grep "${compos1}" bact2_out.txt  | tr '\n' ','`
done
rm *.txt &
