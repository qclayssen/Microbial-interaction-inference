#run with ../src/julia-1.0.1/bin/julia scriptFL_test.jl DATA_FILE GML_NAME.gml

data_path = string(ARGS[1])
save_name = string(ARGS[2])
using FlashWeave
netw_results = learn_network(data_path, sensitive=false, heterogeneous=false, transposed = true)
G = graph(netw_results)

save_network(save_name, netw_results, detailed=true)
