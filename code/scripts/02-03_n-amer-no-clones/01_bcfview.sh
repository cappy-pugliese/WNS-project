#!/bin/bash
#SBATCH --job-name=bcfview
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## variables
IN_VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/01_all-samples/ploidy-1/pd_ploidy-1.vcf.gz
SAMPLES=/home/FCAM/cpugliese/wns/04_vcf/02_other-vcf-scritps/03_n-amer-no-clones/n-amer-no-clones_pd.txt
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
OUTNAME=n-amer-no-clones_filtered.vcf.gz

## load modules
module load bcftools/1.9

## run bcftools
bcftools view -S $SAMPLES \
-i 'QUAL>20' \
-i 'MAF>0.05' \
-v snps \
-m2 \
-M2 \
-Oz \
-o $OUTDIR/$OUTNAME \
$IN_VCF

########### script end