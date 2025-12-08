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
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/plink_files/04_plink-only-pd

cd $OUTDIR

plink2 --vcf $INDIR/only-pd-ploidy1-filtered.vcf.gz \
--make-bed \
--double-id \
--allow-extra-chr \
--maf 0.05 \
--geno 0.1 \
--mind 0.5 \
--out only-pd_ploidy1_filtered_plink

########### script end

## need to change for n-amer, have not made any changes yet