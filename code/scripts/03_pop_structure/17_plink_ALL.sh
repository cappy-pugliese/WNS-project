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
VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/clade-structure-ALL_filtered.vcf.gz
OUTNAME=plink_clade-structure-ALL_filtered
OUTDIR=/home/FCAM/cpugliese/lab_wns/06_pcangsd/02_filtered_vcf/05_ALL-samples

cd $OUTDIR

plink2 \
--vcf $VCF \
--make-bed \
--double-id \
--allow-extra-chr \
--maf 0.05 \
--geno 0.1 \
--mind 0.5 \
--out $OUTNAME
########### script end