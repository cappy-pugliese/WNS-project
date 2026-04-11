#!/bin/bash
#SBATCH --job-name=plink
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

## set variables
VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/only-pd-ploidy1-filtered.vcf.gz
OUTNAME=only-pd_clade-structure-pds_filtered
OUTDIR1=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/01_plink

cd $OUTDIR1

plink2 \
--vcf $VCF \
--snps-only \
--allow-extra-chr \
--chr-set -83 \
--export phylip \
--out $OUTNAME

########### script end