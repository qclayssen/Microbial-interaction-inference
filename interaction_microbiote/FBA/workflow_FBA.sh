#!/usr/bin/env bash
./copy_models.sh ./liste_bacteries.txt
source activate bioinfo
python ./import_carveme_FBA.py > output_pFBA.txt
