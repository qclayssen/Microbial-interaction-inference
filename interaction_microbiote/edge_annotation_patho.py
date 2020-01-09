#!/usr/bin/env python3

# Script pour annoter les edges des bacterie pathogene
#run : ./edge_annotation_patho.py GRAPH.gml dataset/interest_bact.txt
import sys
import os
import networkx as nx


F_interrest_bact = open(sys.argv[2],'r')
F_interrest_bact= F_interrest_bact.readline()
list_bact = F_interrest_bact.split(",")

oldG = nx.read_gml(sys.argv[1])
G = nx.MultiDiGraph()

for node in oldG.nodes() :
    famille=node.split("_")
    if famille[0] in list_bact:
        G.add_node(node, pathogene='1')
    else:
        G.add_node(node, pathogene='0')
print(list_bact)


nx.write_gml(G, "./FlashWeave/graph_flashweave/pathogene_"+os.path.basename(sys.argv[1]))
