#!/bin/bash
#SBATCH --job-name=pcangsd
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 6
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

hostname
date

## load modules
module load pcangsd/1.0
source /home/FCAM/cpugliese/.bashrc
conda activate pcangsd

## set variables
PLINK=plink_clade-structure-ALL_filtered
OUTDIR=/home/FCAM/cpugliese/lab_wns/06_pcangsd/02_filtered_vcf/05_ALL-samples
PCANGSD="python3 /isg/shared/apps/pcangsd/1.0/pcangsd/pcangsd.py"

cd $OUTDIR

## PCAnsd
$PCANGSD -plink $PLINK \
-admix \
-out pcangsd_ALL-samples


conda deactivate

########### script end