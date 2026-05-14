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
    # change:
SAMPLES=/home/FCAM/cpugliese/wns/04_vcf/02_other-vcf-scritps/02_only-n-amer-pd/n-amer_pd.txt
OUTNAME=n-amer_filtered_branchlengths2.vcf.gz
    # stay the same:
IN_VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/01_all-samples/ploidy-1/pd_ploidy-1.vcf.gz
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/01_filtered-vcfs

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