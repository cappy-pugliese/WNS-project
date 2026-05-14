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
module load iqtree/2.2.2

## set variables
OUTNAME=03_n-amer_filtered_mf
PLINK=n-amer_filtered_branchlengths_plink

INDIR=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/02_plink
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/03_iqtree


cd $OUTDIR

iqtree2 \
-redo \
-pre $OUTNAME \
-nt 8 \
-cptime 1140 \
-mem 5G \
-m MF \
-s $INDIR/$PLINK.phy

########### script end