#!/bin/bash
#SBATCH --job-name=plink
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=2G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

## set variables
VCF=/home/FCAM/cpugliese/wns/03_bam2gvcf/04_n-amer_pd_vcf2/n-amer-pd_snp-count2_filtered.vcf.gz
OUTNAME=n-amer-pd_clade-structure
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/01_plink

cd $OUTDIR

plink2 \
--vcf $VCF \
--snps-only \
--allow-extra-chr \
--chr-set -83 \
--export phylip \
--out $OUTNAME

########### script end

#/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/scripts
