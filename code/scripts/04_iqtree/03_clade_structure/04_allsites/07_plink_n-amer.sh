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
VCF=n-amer_filtered_branchlengths2.vcf.gz
OUTNAME=n-amer_filtered_branchlengths_plink

INDIR=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/01_filtered-vcfs
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/02_plink

cd $OUTDIR

plink2 \
--vcf $INDIR/$VCF \
--snps-only \
--geno 0.1 \
--mind 0.5 \
--allow-extra-chr \
--chr-set -83 \
--export phylip \
--out $OUTNAME

########### script end
