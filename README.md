# Interaction microbiote

## Installation

Few tools need to be installed to make this project up and running. First, this project is running some python scripts utilizing some packages, in order to run them please install given python environment using this line at project root:

    # Create a conda environment
    conda env create -f ./python_env/bioinfo.yml

You also need to install julia and FlashWeave package. In order to do this please execute those lines:

    # Install dependencies
    sudo apt-get install build-essential libatomic1 python gfortran perl wget m4 cmake pkg-config
    # Download sources
    git clone git://github.com/JuliaLang/julia.git
    # Go in downloaded repositorie
    cd julia
    # Make binaries
    make
    # Execute binary
    ./julia
    # Install FlashWeave
    # In an interactive Julia session, you can then install FlashWeave after typing ] via
    add FlashWeave
## Launch project
A script can handle with all scripts of this project. To execute all this project please excute following line at project's root:

    ./one_script_to_rule_them_all

## Built with

-   [Julia](https://github.com/JuliaLang/julia) - A high-level, high-performance dynamic language for technical computing
-   [FlashWeave](https://github.com/meringlab/FlashWeave.jl) - FlashWeave predicts ecological interactions between microbes from large-scale compositional abundance data
-   [cobrapy](https://github.com/opencobra/cobrapy) -  a constraint-based modeling package that is designed to accommodate the biological complexity of the next generation of COBRA models and provides access to commonly used COBRA methods, such as flux balance analysis, flux variability analysis, and gene deletion analyses
-   [Anaconda](https://www.anaconda.com/) - Environment management
-   [Networkx](https://networkx.github.io/) - Python library used to generate network graph
