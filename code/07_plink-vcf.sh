#!/bin/bash
#SBATCH --job-name=plink-vcf
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
module load plink/2.00a2.3LM

## set variables
INDIR=/home/FCAM/cpugliese/wns-lab/vcfs/01_orig-vcfs
PLDIR=/isg/shared/apps/plink/2.00a2.3LM/
OUTDIR=/home/FCAM/cpugliese/wns-lab/vcfs/03_filtered-vcfs

cd $OUTDIR

$PLDIR/plink2 --vcf $INDIR/pd.vcf.gz \
--make-bed \
--double-id \
--extra-chrs #wrong filter name, need to fix \
--maf 0.05 \
--geno 0.1 \
--mind 0.5 \
--out plink_pd

########### script end