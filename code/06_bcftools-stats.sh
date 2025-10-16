#!/bin/bash
#SBATCH --job-name=bcftools_stats
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=2G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=caprina.pugliese@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
module load bcftools/1.20

## Variables
INDIR=/home/FCAM/cpugliese/wns-lab/gvcfs/03_joint-calling/ploidy-1
REF=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pdestructans.fasta
OUTDIR=/home/FCAM/cpugliese/wns-lab/gvcfs/03_joint-calling/02_stats_ploidy-1

## run bcftools stats
cd $INDIR
bcftools stats -F $REF pd_ploidy-1.vcf.gz > pd_ploidy-1_bcftools_stats.vchk

# Plot the stats
plot-vcfstats -p $OUTDIR pd_ploidy-1_bcftools_stats.vchk

########### script end

# The final looks can be customized by editing the generated 'outdir/plot.py' script and re-running manually cd outdir && python plot.py && pdflatex summary.tex