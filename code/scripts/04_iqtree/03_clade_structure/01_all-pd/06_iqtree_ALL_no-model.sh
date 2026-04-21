#!/bin/bash
#SBATCH --job-name=iqtree
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

## modules needed:
module load iqtree/3.0.1

## set variables
OUTNAME=plink_clade-structure-ALL_filtered
PLINK=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/01_plink/plink_clade-structure-ALL_filtered
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/02_iqtree


cd $OUTDIR

iqtree3 \
-redo \
-pre $OUTNAME \
-nt 4 \
-cptime 1140 \
-bb 1000 \
-mem 5G \
-o Pd_31 \
-s $PLINK.phy

########### script end