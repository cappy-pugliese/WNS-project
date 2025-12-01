#!/bin/bash
#SBATCH --job-name=Dsuite
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=10G
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
# set variables
DSUITE=/home/FCAM/cpugliese/bin/Dsuite/Build/Dsuite
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
OUTDIR=/home/FCAM/cpugliese/wns/05_pop_structure/01_dsuite

cd $OUTDIR

$DSUITE Dtrios $INDIR/pd_filtered.vcf.gz pd_dsuite_table.tsv -o pd_dsuite

########### script end