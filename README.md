# BacterialMorpholgies_FlowModels
Code for the transport-dependent colonization and mechanics-dependent colonization models used in "Bacterial species with different nanocolony morphologies have distinct flow-dependent colonization behaviors" by Hallinen, K.M., Bodine, S.P., Stone, H.A., Muir, T.W, Wingreen, N.S., and Gitai, Z., PNAS (2024)

## Transport Model
In the transport model folder, you will find 3 matlab files. ODE_EF_ModelFigure3 will run the ODE transport model and create the graph from figure 3 in the paper, with a positive beta term. ODE_Staph_ModelFigure3 will run the ODE transport model and create the graph from figure 3 in the paper, with a negative beta term. ODE_Staph_IntermediateFlows_forSupplement will run the ODE model at the intermediate flow rates and create the graph for the model prediction shown in figure S4. 

## Mechanics Model 
In the mechanics model folder, use any of the runMultipleChains_* to run a simulation of 100 chains- there are high and low flow scripts for both the wildtype (runMultipleChains_High and runMultipleChains_Low) and the Long chain mutant (LCM: runMultipleChains_LCMHigh and runMultipleChains_LCMLow). Each script when run once is used to mimic an experimental run. These scripts call testModel (or testModel_LCM), which initalizes a chain, then calculates the forces, breakages, attachments, detchments, growth, and movement of the chain, and repeats these calculations and analysis for a set amounnt of steps. 
For each simulated run, data can be saved as .mat files and plotted using plotTotalCounts or plotTotalCounts_LCM. These scripts expect there to be 3 datasets, saved as totalCounts_High1, totalCounts_High2, etc.,  for each simulated condition. These same saved datasets are used in analyzeMultipleChains to create plots for the breakage events of each condition. 
