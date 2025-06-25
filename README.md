<h1 align="center">phyloTree, a Phylogenetic Analysis Workflow using Nextflow and Singularity</h1>


<h3 align="center">M. Asaduzzaman Prodhan<sup>*</sup></h3>


<div align="center"><b> DPIRD Diagnostics and Laboratory Services </b></div>


<div align="center"><b> Department of Primary Industries and Regional Development </b></div>


<div align="center"><b> 3 Baron-Hay Court, South Perth, WA 6151, Australia </b></div>


<div align="center"><b> <sup>*</sup>Correspondence: Asad.Prodhan@dpird.wa.gov.au </b></div>


<br />


<p align="center">
  <a href="https://github.com/asadprodhan/phyloTree/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-GPL%203.0-yellow.svg" alt="License GPL 3.0" style="display: inline-block;"></a>
  <a href="https://orcid.org/0000-0002-1320-3486"><img src="https://img.shields.io/badge/ORCID-green?style=flat-square&logo=ORCID&logoColor=white" alt="ORCID" style="display: inline-block;"></a>
</p>


<br />


## **Step 1: Create a conda environment and install the required packages**


- Create a conda environment

  ```
  conda create -n phyloTree
  ```

- Activate the environment

  ```
  conda activate phyloTree
  ```

- Install the following packages

    ```
    conda install -c bioconda nextflow
    ```

    ```
    conda install -c conda-forge singularity
    ```

    ```
    conda install -c bioconda trimal
    ```

    ```
    conda install bioconda::iqtree
    ```

    ```
    conda install bioconda::emboss
    ```

    ```
    conda install conda-forge::dos2unix
    ```

    ```
    conda install bioconda::mafft
    ```

<br />

## **Step 2: Make an alignment and trim it**

    ```
    mafft --auto all_genomes_concatenated_together.fasta > all_genomes_alignment.fasta
    ```

    ```
    trimal -in all_genomes_alignment.fasta -out trimmed_all_genomes_alignment.fasta -gappyout
    ```

<br />

## **Step 3: Find the best model**

    ```
    iqtree2 -s trimmed_all_genomes_alignment.fasta -mset JC,F81,K2P,HKY85,GTR,SYM,TrN,JC+I,JC+G,JC+I+G,F81+I,F81+G,F81+I+G,K2P+I,K2P+G,K2P+I+G,HKY85+I,HKY85+G,HKY85+I+G,GTR+I,GTR+G,GTR+I+G,SYM+I,SYM+G,SYM+I+G,TrN+I,TrN+G,TrN+I+G -m TEST
    ```

    - The above command tests only the MrBayes supported models
    

## **Step 2: Run phyloTree pipeline**


- Make a directory


- Keep your alignment/s (nexus format, e.g., cox1_alignment.nex) in this directory


> Note: you can only replace ‘cox1’. Your alignment name must end up with ‘_alignment.nex’.


- Keep the following file (again, nexus format, e.g., zzz_mrbayes_parameters.nex) in the same directory. 


```
BEGIN mrbayes;
lset nst=6 rates=invgamma; 
propset ExtTBR$prob=0; 
mcmc ngen=1000000 printfreq=100 samplefreq=1000 diagnfreq=1000 nchains=4 savebrlens=yes;
sumt burnin=12500;
sump burnin=12500;
END;
```


- “zzz_mrbayes_parameters.nex” contains the analysis run parameters. You can modify them. See the explanation below.


- however, you must keep the file name same, i.e., “zzz_mrbayes_parameters.nex”


- Run the following command


```
nextflow run asadprodhan/phyloTree -r 73f3c10
```

<br />


## **Step 3: Look at the outputs**


- phyloTree will generate three directories


    - ‘results’ that contains the results 
    
    
    - ‘reports’ that contains the run reports


    - ‘work’ that contains the temporary files


- Visualise the tree 


    - ‘yourAlignmentName.mrbayes.con.tre’ is the file that contains the tree with the ‘posterior probability’ supports. You can visualise the tree using FigTree (http://tree.bio.ed.ac.uk/software/figtree/).


<br />



## **Parameters in the “zzz_mrbayes_parameters.nex” file explained**



- “lset nst=6 rates=invgamma” sets a nucleotide substitution model called “GTR + I + G” 


> The usage of maximum likelihood method in phylogenetic analysis requires a nucleotide substitution model such as “GTR + I + G”. “GTR + I + G” is a widely used General Time Reversible (GTR) nucleotide substitution model with gamma-distributed rate variation across sites (G) and a proportion of invariable sites (I).  The invariable sites account for the static, unchanging sites in a dataset. 



- “ngen” is the number of generations for which the analysis will be run


- “printfreq” controls the frequency with which brief info about the analysis is printed to screen. The default value is 1,000.


- “samplefreq” determines how often the chain is sampled; the default is every 500 generations


- diagnostics calculated every “diagnfreq” generation


- By default, MrBayes uses Metropolis coupling to improve the MCMC sampling of the target distribution. The Swapfreq, Nswaps, Nchains, and Temp settings together control the Metropolis coupling behavior. When Nchains is set to 1, no heating is used. When Nchains is set to a value n larger than 1, then n−1 heated chains are used. By default, Nchains is set to 4, meaning that MrBayes will use 3 heated chains and one “cold” chain.


- “sumt” summarises statistics and creates five additional files


- “sump” summarises the parameter values


- sumt or sump is calculated as  = (number of generations/sample frequency)/4. ‘4’ represents 25%


- Every time the diagnostics are calculated, either a fixed number of samples (burnin) or a percentage of samples (burninfrac) from the beginning of the chain is discarded.


<br />


