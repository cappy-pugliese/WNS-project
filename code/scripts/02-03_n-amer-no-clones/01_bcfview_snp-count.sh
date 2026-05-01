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
VCF=/home/FCAM/cpugliese/wns/03_bam2gvcf/04_n-amer_pd_vcf2/ONLY_n-amer_no-clones.vcf.gz
OUTDIR=/home/FCAM/cpugliese/wns/03_bam2gvcf/04_n-amer_pd_vcf2
OUTNAME=ONLY_n-amer_no-clones_filtered.vcf.gz

## filter using bcftools
module load bcftools/1.9

cd $OUTDIR

bcftools view \
-i 'QUAL>20' \
-i 'MAF>0.05' \
-v snps \
-m2 \
-M2 \
-Oz \
-o $OUTNAME \
$VCF

########### script end

# check on consol
# then run joint
# then run bcfview