# #!/bin/bash
# ################################################################################
# # script pour nettoyer les lignes nulles
# ################################################################################
# ./scripts/new_data.sh
# echo "new_data done"
# ################################################################################
# # fait tourner flashweave sans tenir en compte la FBA
# ################################################################################
# # genere 2 graph sans prendre en compte carveme
# # 1 graph global et un reduit aux pathogenes
#     # run flashweave sur les datas pas encore adaptées à carveme
#     ./FlashWeave/src/julia-1.0.1/bin/julia ./scripts/scriptFL_test.jl ./dataset/new_data_lower.csv ./FlashWeave/graph_flashweave/raw_data_flashweave.gml
#
#     # script pour reduire le reseau au bacterie d'interet et celle qui y sont liées
#     ./scripts/reduce_graph_to_patogen_edges.py ./FlashWeave/graph_flashweave/raw_data_flashweave.gml ./FlashWeave/graph_flashweave/reduced_raw_data_flashweave.gml
#
# ################################################################################
# # purge le dataset de ce qui est pas dans carveme
# ################################################################################
# # script pour tout adapter à carveme
# ./scripts/parsing.sh
# echo "parsing done"
#
# ################################################################################
# # fait tourner flashweave sur le dataset adapté à flashweave
# ################################################################################
# # 1 graph global et un reduit aux pathogenes
#     # run flashweave sur les datas pas encore adaptées à carveme
#     ./FlashWeave/src/julia-1.0.1/bin/julia ./scripts/scriptFL_test.jl ./dataset/new_data_match.csv ./FlashWeave/graph_flashweave/parsed_data_graph.gml
#
#     # script pour reduire le reseau au bacterie d'interet et celle qui y sont liées
#     ./scripts/reduce_graph_to_patogen_edges.py ./FlashWeave/graph_flashweave/parsed_data_graph.gml ./FlashWeave/graph_flashweave/reduced_parsed_data_graph.gml
#
# ################################################################################
# # Annotation du graphique réduit
# ################################################################################
#     # sort la liste des nodes du graph
#     ./scripts/output_node_list.py ./FlashWeave/graph_flashweave/reduced_parsed_data_graph.gml ./FBA/liste_bacteries.txt
#
#     # sort la liste des edges
#     ./scripts/get_bacteria_couples.py ./FlashWeave/graph_flashweave/reduced_parsed_data_graph.gml ./FBA/FBA_parsing/edge_list_data_parsed.csv
#
#     # fait la FBA de toutes les bactéries du graph
#     cd ./FBA/
#     ./workflow_FBA.sh
#     echo "pFBA done"
#
#     # recupere les informations pour annoter le graphique
#     cd ./FBA_parsing/
#     ./FBA_parsing.sh
#     echo "pFBA parsing done"
#
#     # annote le graphique
#     cd ../../
#     ./scripts/edge_annotation.py ./FlashWeave/graph_flashweave/reduced_parsed_data_graph.gml ./FBA/FBA_parsing/flux_fba.txt ./dataset/interest_bact.txt
#     echo "annotation done"
# ################################################################################
# # Annotation du graphique global
# ################################################################################
# # sort la liste des nodes du graph
# ./scripts/output_node_list.py ./FlashWeave/graph_flashweave/parsed_data_graph.gml ./FBA/liste_bacteries.txt
#
# # sort la liste des edges
# ./scripts/get_bacteria_couples.py ./FlashWeave/graph_flashweave/parsed_data_graph.gml ./FBA/FBA_parsing/edge_list_data_parsed.csv
#
# # fait la FBA de toutes les bactéries d'intéret
# cd ./FBA/
# ./workflow_FBA.sh
# echo "pFBA done"
#
# cd ./FBA_parsing/
# ./FBA_parsing.sh ./edge_list_data_parsed.csv
# echo "pFBA parsing done"
#
# cd ../../
./scripts/edge_annotation.py ./FlashWeave/graph_flashweave/parsed_data_graph.gml ./FBA/FBA_parsing/flux_fba.tsv ./dataset/interest_bact.txt
