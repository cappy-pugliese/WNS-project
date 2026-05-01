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
IN_VCF=/home/FCAM/cpugliese/wns/03_bam2gvcf/04_n-amer_pd_vcf2/n-amer-pd_snp-count2_filtered.vcf.gz
SAMPLES=/home/FCAM/cpugliese/wns/04_vcf/02_other-vcf-scritps/05_clade-structure_pds/n-amer_no-clones.txt
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
OUTNAME=snp-count_n-amer_no-clones_filtered.vcf.gz

## load modules
module load bcftools/1.19

## run bcftools
bcftools view -S $SAMPLES \
-Oz \
-o $OUTDIR/$OUTNAME \
$IN_VCF

########### script end