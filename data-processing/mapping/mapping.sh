#!/usr/bin/env bash

# requirement `Samtools > 1.3 bwa bedtools`

# 1. index the reference genome
# 2. single-end mapping
# 3. Fix mates and compress
# 4. sorting
# 5. remove dupicates * applicable if were mapping reads
# 6. index and get mapping stats

mkdir  ../results/sam ../results/bam ../results/fixmate ../results/sorted ../results/dedup

#1
cd ../ref-genome

bwa index Magnaporthe_oryzae_E2.mainGenome.fasta

cd -

#2
for sample in $(ls ../data); do

    bwa mem ../ref-genome/Magnaporthe_oryzae_E2.mainGenome.fasta ../data/${sample} -t 8 > ../results/sam/${sample::-8}.sam

done


#3

cd ../results/sam

for sample in $(ls ); do

    samtools sort -n -O sam ${sample} --threads 8 | samtools fixmate -m -O bam - ../fixmate/${sample::-4}.fixmate.bam --threads 8

done

cd -

#4
cd ../results/fixmate

for sample in $(ls ); do

    samtools sort -n -O bam -o ../sorted/${sample::-4}.sorted.bam ${sample} --threads 8

done

cd -

#5 Not applicaple these are scafolds not reads.

# cd ../results/dedup

# for sample in $(ls ); do

#     samtools markdup -r -S ${sample} ${sample::-4}.dedup.bam

# done

# cd -

#6

cd ../results/sorted

for sample in $(ls ); do

    samtools index ${sample}
    samtools flagstat ${sample} >> ../mapping_stats.txt
    echo "#####################  ${sample::-11}  ########################" >> ../mapping_stats.txt

done

cd -

echo "DONE!!"