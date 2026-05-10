#!/bin/bash
#SBATCH --job-name=iqtree
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

## modules needed:
module load iqtree/3.0.1

## set variables
OUTNAME=n-amer_no-clones_filtered_b1000
PLINK=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/01_plink/plink_n-amer_no-clones_filtered
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/02_iqtree


cd $OUTDIR

iqtree3 \
-redo \
-pre $OUTNAME \
-nt 8 \
-cptime 1140 \
-b 1000 \
-mem 5G \
-m GTR+ASC \
-s $PLINK.phy

########### script end