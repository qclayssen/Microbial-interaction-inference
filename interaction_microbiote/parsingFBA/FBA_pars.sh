#!/usr/bin/env bash




while read line
do
        echo $line | cut -f 1 -d "," > first_bacteria
        echo $line | cut -f 2 -d "," > second_bacteria
        bacteria1=`cat first_bacteria`
        bacteria2=`cat second_bacteria`
        awk '/'${bacteria1}/'{flag=1;next}/PID/{flag=0}flag' ../FBA/output_FVA.txt && awk '/'${bacteria2}'/{flag=1;next}/PID/{flag=0}flag' ../FBA/output_FVA.txt &&
        list_in_bact1=`awk '{printf $1}' ${bacteria1}_fba.txt`
        list_in_bact2=`awk '{print $1}' ${bacteria2}_fba.txt`
        list_out_bact1=`awk '{print $5}' ${bacteria1}_fba.txt`
        list_out_bact2=`awk '{print $5}' ${bacteria2}_fba.txt`
        for bact1_in in list_in_bact1
        do
          grep $bact1_in $list_out_bact2 > ${bacteria1}__${bacteria2}.txt
        done

        for bact1_in in list_in_bact1
        do
          grep $list_in_bact2 $list_out_bact1 > ${bacteria2}__${bacteria1}.txt
        done
done < "../FlashWeave/data_flashweave/edge_list_small.csv"

awk '/frankineae_bacterium/{flag=1;next}/PID/{flag=0}flag' ../FBA/output_FVA.txt > frankineae_bacterium_fba.txt
