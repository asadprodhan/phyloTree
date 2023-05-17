# **phyloTree, an automated, reproducible, and scalable workflow for Bayesian phylogenetic analysis using Nextflow and Singularity** <br />


## **Step 1: Install Nextflow and Singularity**

```
conda install -c bioconda nextflow
```


```
conda install -c conda-forge singularity
```


## **Step 2: Run phyloTree**


- Make a directory


- Keep your alignments (nexus format, e.g., cox1_alignment.nex) in this directory


> Note: you can only replace ‘cox1’. Your alignment name must end up with ‘_alignment.nex’.


- Keep the following file (again, nexus format, e.g., zzz_mrbayes_parameters.nex) in the same directory. 


    - “zzz_mrbayes_parameters.nex” contains the analysis run parameters. You can modify them


    - however, you must keep the file name same, i.e., “zzz_mrbayes_parameters.nex”


- Run the following command


```
nextflow run asadprodhan/phyloTree -r 73f3c10
```


## **Step 3: Look at the outputs**


- phyloTree will generate three directories


    - ‘results’ that contains the results 
    
    
    - ‘reports’ that contains the run reports


    - ‘work’ that contains the temporary files


- Visualise the tree 


    - ‘yourAlignmentName.mrbayes.con.tre’ is the file that contains the tree with the ‘posterior probability’ supports


## **Parameters in the “zzz_mrbayes_parameters.nex” file explained**



- “lset nst=6 rates=invgamma” sets a nucleotide substitution model called “GTR + I + G” 


The usage of maximum likelihood method in phylogenetic analysis requires a nucleotide substitution model such as “GTR + I + G”. “GTR + I + G” is a widely used General Time Reversible (GTR) nucleotide substitution model with gamma-distributed rate variation across sites (G) and a proportion of invariable sites (I).  The invariable sites account for the static, unchanging sites in a dataset. 



- “ngen” is the number of generations for which the analysis will be run


- “printfreq” controls the frequency with which brief info about the analysis is printed to screen. The default value is 1,000.


- “samplefreq” determines how often the chain is sampled; the default is every 500 generations


- diagnostics calculated every “diagnfreq” generation


- By default, MrBayes uses Metropolis coupling to improve the MCMC sampling of the target distribution. The Swapfreq, Nswaps, Nchains, and Temp settings together control the Metropolis coupling behavior. When Nchains is set to 1, no heating is used. When Nchains is set to a value n larger than 1, then n−1 heated chains are used. By default, Nchains is set to 4, meaning that MrBayes will use 3 heated chains and one “cold” chain.


- “sumt” summarises statistics and creates five additional files


- “sump” summarises the parameter values


- sumt or sump is calculated as  = (number of generations/sample frequency)/4. ‘4’ represents 25%


- Every time the diagnostics are calculated, either a fixed number of samples (burnin) or a percentage of samples (burninfrac) from the beginning of the chain is discarded.
