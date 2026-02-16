#!/bin/bash
#SBATCH --job-name=bcftools
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

## load modules
module load bcftools/1.20

## set variables
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/
VCF=n-amer-no-wisconsin_filtered.vcf.gz

cd $INDIR

## bcftools
bcftools index \
$VCF

########### script end