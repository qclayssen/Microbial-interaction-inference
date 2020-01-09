#!/usr/bin/env python3

# Script pour annoter les edges et orienter le graphique en fonction de la sortie FBA
#run : ./edge_annotation.py GRAPH.gml List_of_component.txt List_of_interest_bacteria.txt (can be found in data_flashweave)

import sys
import os
import networkx as nx

F_fba = open(sys.argv[2], "r")
dict = {}
for line in F_fba:
    if ("source" not in line and line != ""):
        line = line.replace(",\n","")
        line = line.replace("\n","")
        ar_component = line.split("\t")
        if len(ar_component[2]) != 0:
            ar_component[2] = ar_component[2].replace('_','')
            ar_component[2] = ar_component[2].replace('_e','')
            ar_component[2] = ar_component[2].replace('_L','')
            dict[(ar_component[0],ar_component[1])] = ar_component[2]

F_fba.close()

F_interrest_bact = open(sys.argv[3],'r')
for line in F_interrest_bact:
    if (line != ""):
        list_bact = line.split(",")


oldG = nx.read_gml(sys.argv[1])
att_weight = nx.get_edge_attributes(oldG, 'weight')

G = nx.MultiDiGraph()

for node in oldG.nodes() :
    G.add_node(node, result='FP')

for key in dict.keys():
    tmp_dict = {}
    source = key[0]
    target = key[1]
    ar_comp = dict.get(key).split(",")

    for comp in ar_comp:
        if (not comp[0].isdigit()):
            tmp_dict[comp] = comp

    check = True
    try:
        tmp_dict["weight"] = att_weight[source,target]
    except:
        try:
            tmp_dict["weight"] = att_weight[target,source]
        except:
            check = False
    if check:
        data = (source, target, tmp_dict)
        G.add_edges_from([data])


for node in G.nodes() :
    for nei_node in nx.all_neighbors(G, node):
        G.add_node(nei_node, result='TP')


for key in dict.keys():
    source = key[0]
    target = key[1]
    for bact in list_bact:
        if bact in source:
            G.add_node(source, result='interest')
        elif (bact in target):
            G.add_node(target, result='interest')

nx.write_gml(G, "./FlashWeave/graph_flashweave/annotated_"+os.path.basename(sys.argv[1]))
