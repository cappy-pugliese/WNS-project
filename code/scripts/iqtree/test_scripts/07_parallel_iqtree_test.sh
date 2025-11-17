#!/bin/bash
#SBATCH --job-name=iqtree
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=3G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
source ~/.bashrc
module load bcftools/1.20
module load iqtree/3.0.1
module load parallel/20180122

## set variables
NAMEFILE=test2_names.txt
WIND=/home/FCAM/cpugliese/wns/06_iqtree/01_text-files
TMP=/home/FCAM/cpugliese/wns/06_iqtree/02_test-runs/02_test-run/

cd $TMP
cat $WIND/$NAMEFILE | parallel -j 1 sbatch {}

########### script end