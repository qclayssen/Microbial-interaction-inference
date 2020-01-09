#!/usr/bin/env python3

# Script pour récupérer la liste des edges à caractériser par FBA
import networkx as nx
import os
import sys


# get the actual network
reseau = nx.read_gml(sys.argv[1])
# get the edge list
edge_list = reseau.edges(data=True)
# interest bacterias
interest_list = ["lactococcus", "lactobacillus", "holdemania", "pseudomonas", "enterobacteriaceae", "prevotella", "breve", "enterococcus"]
# nouveau reseau
reseau2 = nx.Graph()

# parcours la edge list
for edge in edge_list:
    for bacteria in interest_list:
        if bacteria in edge[0] or bacteria in edge[1]:
            reseau2.add_edge(edge[0], edge[1], weight=edge[2]["weight"])
            break

nx.write_gml(reseau2, sys.argv[2])
