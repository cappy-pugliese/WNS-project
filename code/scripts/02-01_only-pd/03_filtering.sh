#!/bin/bash
#SBATCH --job-name=filtering
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=2G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
module load bcftools/1.9

## variables
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/only_pd/01_ploidy1
VCF=only-pd.vcf.gz
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
NAME=only-pd-ploidy1-filtered

cd $INDIR
bcftools view \
-i 'QUAL>20' \
-i 'MAF>0.05' \
-v snps \
-m2 \
-M2 \
-Oz \
-o $OUTDIR/$NAME.vcf.gz \
$INDIR/$VCF

########### script end