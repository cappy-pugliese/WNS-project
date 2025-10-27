#!/bin/bash
#SBATCH --job-name=bcftools
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=5G
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
module load bcftools/1.9

## set variables
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs

cd $OUTDIR

## bcftools
bcftools view \
-i 'QUAL>20' \
-i 'MAF>0.05' \
-v snps \
-m2 \
-M2 \
-Oz \
-o $OUTDIR/pd_filtered.vcf.gz \
$INDIR/pd.vcf.gz

########### script end

#bcftools_viewCommand=view -i QUAL>20 -v snps -m2 -M2 -Oz -o pd_biallelic_snps.vcf.gz pd.vcf.gz