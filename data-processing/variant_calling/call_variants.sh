#!/usr/bin/env bash

source activate mapping

data_dir=/home/jmulama/FMB-re-analysis/working-dir/mapping/results/dedup
data_dir2=/home/jmulama/FMB-re-analysis/working-dir/mapping/results/sorted

ref=/home/jmulama/FMB-re-analysis/working-dir/mapping/ref-genome/Magnaporthe_oryzae_E2.mainGenome.fasta

rm samples.txt

# create alsit of the samples to be called
for i in $(ls $data_dir2); do
        echo "$i" >> samples2.txt
done

txt_dir=/home/jmulama/FMB-re-analysis/working-dir/variant-calling/freebayes/scripts
mkdir out2
output_dir=out2

cd $data_dir2

freebayes -f ${ref} -p 1 -L ${txt_dir}/samples2.txt | gzip > $txt_dir/${output_dir}/bayes_var.vcf.gz

cd -
