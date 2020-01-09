#!/usr/bin/env python3

# Script pour récupérer la liste des edges à caractériser par FBA
import networkx as nx
import os
import sys

reseau = nx.read_gml(sys.argv[1])


F2 = open(sys.argv[2],'w')
for x in reseau.node():
    F2.write(x + '\n')
