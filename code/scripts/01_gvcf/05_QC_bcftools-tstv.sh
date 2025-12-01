#!/bin/bash
#SBATCH --job-name=bcftools_stats
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=2G
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
module load bcftools/1.20

cd /home/FCAM/cpugliese/wns-lab/gvcfs/03_joint-calling

bcftools filter -i'QUAL>20' pd.vcf.gz | bcftools stats

########### script end