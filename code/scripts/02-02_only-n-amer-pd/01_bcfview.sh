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
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/02_only-pd/01_ploidy1
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/03_only-n-amer-pd
SAMPLES=/home/FCAM/cpugliese/wns/04_vcf/02_other-vcf-scritps/02_only-n-amer-pd/n-amer_pd.txt
OUTDIR2=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs

## load modules
module load bcftools/1.19

## run bcftools to view north american samples only
bcftools view -S $SAMPLES \
-Oz \
-o $OUTDIR/snp-count_n-amer_ploidy1_pd.vcf.gz \
$INDIR/only-pd.vcf.gz


## filter using bcftools
module purge
module load bcftools/1.9

bcftools view -S $SAMPLES \
-i 'QUAL>20' \
-i 'MAF>0.05' \
-v snps \
-m2 \
-M2 \
-Oz \
-o $OUTDIR2/snp-count_n-amer-pd-only_filtered.vcf.gz \
$INDIR/only-pd.vcf.gz

########### script end