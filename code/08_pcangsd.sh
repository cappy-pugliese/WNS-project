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

## load modules
module load pcangsd/1.0
module load python/3.10.1

## set variables
INDIR=/home/FCAM/cpugliese/wns-lab/vcfs/03_filtered-vcfs/plink_files
OURDIR=/home/FCAM/cpugliese/wns-lab/vcfs/04_pcangsd
PCANGSD="python3 /isg/shared/apps/pcangsd/1.0/pcangsd/pcangsd.py"

cd $OUTDIR

## PCAnsd
$PCANGSD -plink $INDIR/plink_pd \
-threads 25 \
-out pcangsd_pd

########### script end