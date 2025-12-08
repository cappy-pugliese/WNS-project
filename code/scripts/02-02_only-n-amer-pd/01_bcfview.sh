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
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/01_all-samples/ploidy-1
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/03_only-n-amer-pd
SAMPLES=/home/FCAM/cpugliese/wns/04_vcf/scripts/only-n-amer-pd/n-amer_pd.txt
OUTDIR2=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs

## load modules
module load bcftools/1.20

## run bcftools to view north american samples only
bcftools view -S $SAMPLES \
-Oz \
-o $OUTDIR/n-amer_ploidy1_pd.vcf.gz \
$INDIR/pd_ploidy-1.vcf.gz


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
-o $OUTDIR2/n-amer-pd-only_filtered.vcf.gz \
$INDIR/pd_ploidy-1.vcf.gz

########### script end