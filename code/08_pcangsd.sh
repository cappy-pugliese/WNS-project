#!/bin/bash
#SBATCH --job-name=pcangsd
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 25
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

########## HAVE NOT ADDED THIS LINE IN YET ON CLUSTER

## load modules
module load pcangsd/1.0
source /home/FCAM/cpugliese/.bashrc
conda activate pcangsd

## set variables
INDIR=/home/FCAM/cpugliese/lab_wns/vcfs/03_filtered-vcfs/plink_files
OUTDIR=/home/FCAM/cpugliese/lab_wns/vcfs/04_pcangsd
PCANGSD="python3 /isg/shared/apps/pcangsd/1.0/pcangsd/pcangsd.py"

cd $OUTDIR

## PCAnsd
$PCANGSD -plink $INDIR/plink_pd \
-out pcangsd_pd


conda deactivate
########### script end