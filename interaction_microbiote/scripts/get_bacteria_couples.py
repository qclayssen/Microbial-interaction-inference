#!/usr/bin/env python3

# Script pour récupérer la liste des edges à caractériser par FBA
import networkx as nx
import os
import sys
import re

reseau = nx.read_gml(sys.argv[1])
edge_list = reseau.edges(data=True)
F = open(sys.argv[2],'w')
for x in edge_list:
    bacterie1 = re.findall(r"[a-z]{4,}_[a-z]{5,}", x[0])
    bacterie2 = re.findall(r"[a-z]{4,}_[a-z]{5,}", x[1])
    if len(bacterie2)==0 or len(bacterie1)==0:
        continue
    bacterie2=bacterie2[0]
    bacterie1=bacterie1[0]
    F.write(str(bacterie1) + ',' + str(bacterie2) + '\n')
