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
VCF=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/01_filtered-vcfs/n-amer_filtered_branchlengths.vcf.gz
OUTNAME=n-amer_filtered_branchlengths_plink
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/02_plink

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
