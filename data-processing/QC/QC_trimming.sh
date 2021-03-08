#!/usr/bin/bash


# Quality chech and trimming
# Each isolates was trimmed selectively in accordance with the read qualities, precence or absence of adapter sequences.
# Below is a general command used. 
# Not all sequences were trimed. Some passed the quality check analysis.

fastqc raw_data -o quality_check_stats/fastqc

multiqc raw_data -o quality_check_stats/multiqc

trimmomatic PE {}.1.fq {}.2.fq ../trimmed_data/{}.1_paired.fq ../trimmed_data/{}.1_unpaired_trimmed.fq ../trimmed_data/{}.2__paired.fq ../trimmed_data/{}.2_unpaired_trimmed.fq ILLUMINACLIP:adapters/{}_overRep.fa:2:30:10:2:keepBothReads HEADCROP:4 SLIDINGWINDOW:4:15 MINLEN:36
