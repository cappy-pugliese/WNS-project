#!/bin/bash
#SBATCH --job-name=plink-ld
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=10G
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
module load plink/1.90.beta.4.4

## set variables
INDIR=/home/FCAM/cpugliese/lab_wns/vcfs/01_orig-vcfs
PLDIR=/isg/shared/apps/plink/plink-1.90beta4.4-x86_64/
OUTDIR=/home/FCAM/cpugliese/lab_wns/vcfs/03_filtered-vcfs/plink_files/02_plink-w-ld

cd $OUTDIR

$PLDIR/plink --vcf $INDIR/pd.vcf.gz \
--make-bed \
--double-id \
--allow-extra-chr \
--maf 0.05 \
--geno 0.1 \
--mind 0.5 \
--indep-pairwise 10kb 1000 .5 \
--out plink-w-ld_pd

########### script end
