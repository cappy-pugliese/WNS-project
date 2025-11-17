#!/bin/bash
#SBATCH --job-name=gen_cmds
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=3G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
module load bcftools/1.20

## variables
VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
GENWIND=/home/FCAM/cpugliese/wns/06_iqtree/scripts/01_genWind_cmds.sh
INDIR=/home/FCAM/cpugliese/wns/06_iqtree/01_text-files

cd $INDIR
bash $GENWIND $VCF/pd_filtered.vcf.gz 50000
## needs to be run: `bash genWind.sh <yourvcf> <window_size>`
## originally tried with 10,000 window size
## now trying with 50,000 window size

########### script end
