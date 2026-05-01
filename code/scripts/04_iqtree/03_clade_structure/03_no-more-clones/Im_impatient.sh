#!/bin/bash
#SBATCH --job-name=consensustree
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=2G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start
## modules needed:
module load iqtree/3.0.1

## set variables
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/03_test-tree/
BOOTTREES=unfinished_ALL_no-clones.boottrees

cd $OUTDIR

iqtree3 \
-t $BOOTTREES \
-con

########### script end