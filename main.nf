#!/usr/bin/env nextflow

params.in = "$PWD/*_alignment.nex"
datasetA = Channel.fromPath(params.in)
params.outdir = './results'
		
process mrbayes {
	tag "${x.simpleName}" 				
	publishDir "${params.outdir}/${x.simpleName}", mode:'copy' 	

	input:
	file (x) from datasetA 				

	output:
	file ("${x.simpleName}.*") into mrbayes_ch
        	
	script:
	"""
	cat $x $PWD/zzz_mrbayes_parameters.nex > ${x.simpleName}.mrbayes  
	mb ${x.simpleName}.mrbayes 
					
	"""
}

