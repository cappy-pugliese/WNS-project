#!/bin/bash
#SBATCH --job-name=plink
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
#using plink2.0 alpha (oct19 linux 64bit intel build)

## set variables
IN_VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/n-amer-no-clones_filtered.vcf.gz
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/plink_files/06_plink-n-amer-no-clones
OUTNAME=n-amer-no-clones_ploidy1_filtered_plink

cd $OUTDIR

plink2 --vcf $IN_VCF \
--make-bed \
--double-id \
--allow-extra-chr \
--maf 0.05 \
--geno 0.1 \
--mind 0.5 \
--out $OUTNAME

########### script end