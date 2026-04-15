#!/bin/bash
#SBATCH --job-name=iqtree_3
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 8
#SBATCH --mem=20G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

## modules needed:
module load iqtree/3.0.1

## set variables
OUTNAME=n-amer-pd_clade-structure2
PLINK=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/01_plink/n-amer-pd_clade-structure
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/02_iqtree


cd $OUTDIR

iqtree3 \
-redo \
-pre $OUTNAME \
-nt 8 \
-cptime 1140 \
-b 200 \
-mem 20G \
-m GTR+ASC \
-o Pd_28 \
-s $PLINK.phy

########### script end