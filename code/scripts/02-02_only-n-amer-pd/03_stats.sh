#!/bin/bash
#SBATCH --job-name=bcftools_stats
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=4G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
module load bcftools/1.20
module load vcftools/0.1.16

## variables
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/
VCF=n-amer-pd-only_filtered.vcf.gz
SCRIPT=/home/FCAM/cpugliese/wns/04_vcf/scripts/only-n-amer-pd/02_vcf-analysis.sh*

## run script
cd $INDIR
$SCRIPT $VCF only-n-amer

########### script end