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

## set variables
WIND=/home/FCAM/cpugliese/wns/06_iqtree/test_wind.txt
VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/pd_filtered.vcf.gz
TMP=/home/FCAM/cpugliese/wns/06_iqtree/02_test-run
