#!/bin/bash
#SBATCH --job-name=plink-vcf
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 64
#SBATCH --mem=20G
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


## set variables
INDIR=/home/FCAM/cpugliese/wns-lab/vcfs/03_filtered-vcfs
OURDIR=/home/FCAM/cpugliese/wns-lab/vcfs/04_pcangsd

mkdir $OUTDIR
cd $OUTDIR

## PCAnsd
pcangsd --plink $INDIR/plink_pd \
--eig 2 \
--threads 64
--out pcangsd_pd

########### script end