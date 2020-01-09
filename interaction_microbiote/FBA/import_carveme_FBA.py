import cobra
import os
import time
import threading
from multiprocessing import *
import sys
from cobra.flux_analysis import flux_variability_analysis

NUM_WORKERS = 8


def metabo_FBA_summary(unit):
	print("PID: %s, Process Name: %s, Thread Name: %s" % (
	os.getpid(),
	current_process().name,
	threading.current_thread().name))
	unit = "merged_community/"+unit
	print(unit)
	model = cobra.io.read_sbml_model(unit)
	solution = model.optimize()
	pfba_solution = cobra.flux_analysis.pfba(model)
	model.summary(pfba_solution)
	"""stop = str()
	while(stop != "stop"):
		metabolite_to_sum = str(input("Enter the id of a metabolite "))
		eval("model.metabolites."+metabolite_to_sum+".summary()")
		stop = str(input("Enter stop or press any key to continue "))"""

def metabo_FVA_summary(unit):
	print("PID: %s, Process Name: %s, Thread Name: %s" % (
	os.getpid(),
	current_process().name,
	threading.current_thread().name))
	unit = "merged_community/"+unit
	print(unit)
	model = cobra.io.read_sbml_model(unit)
	model.optimize()
	model.summary(fva=0.95)


####################EXEC###################
community = list()
start_time = time.time()
with open('list_community.txt') as f:
	community = f.read().splitlines()
count = 0
for unit in community:
	procs = []
	proc = Process(target=metabo_FBA_summary, args=(unit,))
	procs.append(proc)
	proc.start()
	count+=1
	if(count % NUM_WORKERS ==0):
		for proc in procs:
			proc.join()

for proc in procs:
	proc.join()
end_time = time.time()
print("Parallel time=", end_time - start_time)


#model.metabo_FVA_summary()
