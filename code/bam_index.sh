#!/bin/bash
#SBATCH --job-name=bam_index
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=5G
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
module load samtools/1.9
module load parallel/20180122

## load variables
ACCLIST=/home/FCAM/cpugliese/wns/02_bam2gvcf/03_accessionlist/acclist_without_Pd03.txt

## files need to be indexed
cd /home/FCAM/cpugliese/wns-lab/bams/

cat $ACCLIST | parallel -j 4 \
  samtools index {}.deduped.bam


echo "index done"
date

########### script end