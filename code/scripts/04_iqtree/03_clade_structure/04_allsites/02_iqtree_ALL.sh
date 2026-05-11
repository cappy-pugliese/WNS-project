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
    # seeing if changing the version helps
    # code for xanadu

## set variables
OUTNAME=01_ALL_filtered_mf
PLINK=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/01_plink/plink_clade-structure-ALL_filtered
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/02_iqtree/01_fixing-branchlengths


cd $OUTDIR

iqtree2 \
-redo \
-pre $OUTNAME \
-nt 8 \
-cptime 1140 \
-mem 5G \
-m MF \
-o Pd_31 \
-s $PLINK.phy

########### script end

## iqtree is crashing for some weird reason
## I don't think? I was running into this issue before
    ## lies I ran into this exact issue before