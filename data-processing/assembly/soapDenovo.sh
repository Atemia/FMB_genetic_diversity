#!/bin/env bash

# for i in $(ls ../clean-data) ; do
#     echo "$i"

#     head -n 25 soapDenovo.config > temp.config
#     echo "q1=../clean-data/${i}.1" >> temp.config
#     echo "q2=../clean-data/${i}.2" >> temp.config
#     #cat temp.config
#     SOAPdenovo-63mer all -s temp.config -K 61 -o ../assembled-data/_asmbly_${i} -p 8

# done

while read L; do
	echo "${L}"
	#echo "q1=../clean-data/${L}.1.fq"
    head -n 25 soapDenovo.config > temp.config
    echo "q1=../clean-data/${L}.1.fq" >> temp.config
    echo "q2=../clean-data/${L}.2.fq" >> temp.config
    #cat temp.config
    SOAPdenovo-63mer all -s temp.config -K 61 -o ../assembled-data/_asmbly_${L} -p 8
done < ../clean-data/lables



# The reads were assembled individually after testing their optimum N50 and the read numbers
# Below is the general script used for optimizing 

#for (( i = 23; i < 62; i+=2 )); do
#        echo "$i"
#	mkdir opt_results_test_$i
#	SOAPdenovo-63mer all -s soapDenovo.config -K ${i} -o opt_results_test_$i/output${i} -p 8
#done

# for (( i = 63; i < 92; i+=2 )); do
#         echo "$i"
#         mkdir 127mer_results_test2_$i
#         SOAPdenovo-127mer all -s soapDenovo.config -K ${i} -o 127mer_results_test2_$i/output${i} -p 8
# done

#SOAPdenovo-63mer all -s soapDenovo.config -K 31 -o results_test/output31 -p $SLURM_NTASKS_PER_NODE

#SOAPdenovo-63mer sparse_pregraph -s soapDenovo.config -K 31 -z genomeSize -o outputGraph [-g maxKmerEdgeLength -d kmerFreqCutoff -e kmerEdgeFreqCutoff -R -r runMode -p 8]