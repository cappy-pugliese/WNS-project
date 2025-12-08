#!/bin/bash
#SBATCH --job-name=pcangsd
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 6
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
module load pcangsd/1.0
source /home/FCAM/cpugliese/.bashrc
conda activate pcangsd

## set variables
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/plink_files/04_plink-only-pd
OUTDIR=/home/FCAM/cpugliese/lab_wns/06_pcangsd/02_filtered_vcf/only_pd
PCANGSD="python3 /isg/shared/apps/pcangsd/1.0/pcangsd/pcangsd.py"
PLINAME=only-pd_ploidy1_filtered_plink

cd $OUTDIR

## PCAnsd
$PCANGSD -plink $INDIR/$PLINAME \
-admix \
-out pcangsd_only-pd


conda deactivate

########### script end