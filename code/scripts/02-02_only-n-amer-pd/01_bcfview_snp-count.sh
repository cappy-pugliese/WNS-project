#!/bin/bash
#SBATCH --job-name=bcfview
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

hostname
date

## variables
SAMPLES=/home/FCAM/cpugliese/wns/04_vcf/02_other-vcf-scritps/02_only-n-amer-pd/n-amer_pd.txt
INDIR=/home/FCAM/cpugliese/wns/03_bam2gvcf/04_n-amer_pd_vcf2

## filter using bcftools
module load bcftools/1.9

bcftools view -S $SAMPLES \
-i 'QUAL>20' \
-i 'MAF>0.05' \
-v snps \
-m2 \
-M2 \
-Oz \
-o $INDIR/n-amer-pd_snp-count2_filtered.vcf.gz \
$INDIR/n-amer-pd_snp-count2.vcf.gz

########### script end