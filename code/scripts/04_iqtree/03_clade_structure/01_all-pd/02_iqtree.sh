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
VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/clade-structure-pds_filtered.vcf.gz
OUTNAME=clade-structure-pds_filtered3
PLINK=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/01_plink/plink_clade-structure-pds_filtered2
OUTDIR2=/home/FCAM/cpugliese/wns/06_iqtree/clade-structure/02_iqtree


cd $OUTDIR2

iqtree3 \
-redo \
-pre $OUTNAME \
-nt 4 \
-cptime 1140 \
-bb 1000 \
-mem 5G \
-o Pd_31 \
-m GTR+ASC \
-s $PLINK.phy

########### script end