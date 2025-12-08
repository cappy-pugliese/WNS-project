#!/bin/bash
#SBATCH --job-name=bcftools_stats
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
module load bcftools/1.20

## Variables
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
REF=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pdestructans.fasta
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/02_stats/03_only-pd/01_bcfplots/02_n-amer-pd
VCF=n-amer-pd-only_filtered.vcf.gz
NAME=n-amer-pd_bcftools_stats.vchk

## run bcftools stats
cd $OUTDIR
bcftools stats -F $REF $INDIR/$VCF > $NAME

# Plot the stats
plot-vcfstats -p $OUTDIR $NAME

########### script end