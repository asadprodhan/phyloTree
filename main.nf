#!/usr/bin/env nextflow

params.in = "$PWD/*.nex"
datasetA = Channel.fromPath(params.in)
params.outdir = './results'
		
process mrbayes {
	tag "${x.simpleName}" 				
	publishDir "${params.outdir}", mode:'copy' 	

	input:
	file (x) from datasetA 				

	output:
	file ("${x.simpleName}.*") into mrbayes_ch
        	
	script:
	"""
	cat $x mrbayes_parameters/zzz_mrbayes_parameters.nex > ${x.simpleName}.mrbayes  
	mb ${x.simpleName}.mrbayes 
		
	"""
}

