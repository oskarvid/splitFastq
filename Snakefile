rule all:
	input:
		expand("Outputs/Coriell_R{read}_L00{lane}.fastq.gz",
			read=['1', '2'], lane=['1', '2', '3', '4', '5', '6', '7']),
		lanes = expand("{lane}",
			lane=['1', '2', '3', '4', '5', '6', '7']),

# This rule creates a tsv file with the contigs grouped into roughly equal combined lengths.
# The script should be improved to create a separate file per group so as to avoid the need
# for the MakeTSVs.sh script which performs this function
rule MakeSequenceGroupings:
	input:
		fq = "Inputs/CoriellIndex_S1_R{read}_001.fastq.gz",
		lanes = "{lane}",
	output:
		"Outputs/Coriell_R{read}_L00{lane}.fastq.gz",
	shell:
		"zgrep -E -A 3 '^@[A-Z][0-9]{{5}}:[0-9]:[A-Z][0-9][A-Z][0-9]{{2}}[A-Z]{{4}}:{input.lanes}' {input.fq} | gzip - > {output}"
