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
OUTNAME=03_n-amer_bb1000_best-fit-model
PLINK=n-amer_filtered_branchlengths_plink

INDIR=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/02_plink
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/03_iqtree


cd $OUTDIR

iqtree3 \
-redo \
-pre $OUTNAME \
-nt 8 \
-cptime 1140 \
-mem 5G \
-bb 1000 \
-m TVM+F+I+R3 \
-bnni \
-s $INDIR/$PLINK.phy

########### script end