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
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/only_pd/01_ploidy1
REF=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pdestructans.fasta
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/02_stats/03_only-pd
VCF=only-pd.vcf.gz
NAME=only-pd_bcftools_stats.vchk

## run bcftools stats
cd $INDIR
bcftools stats -F $REF $VCF > $NAME

# Plot the stats
plot-vcfstats -p $OUTDIR $NAME

########### script end

# The final looks can be customized by editing the generated 'outdir/plot.py' script and re-running manually cd outdir && python plot.py && pdflatex summary.tex