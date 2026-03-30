#!/bin/bash
#SBATCH --job-name=joint-cal
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=6G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

hostname
date

## load modules
module load GATK/4.3.0.0

## define variables
REF=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pdestructans.fasta
GENDBI=/home/FCAM/cpugliese/wns/03_bam2gvcf/04_n-amer_pd_vcf2/01_consol_gvcf
INTLIST=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pd_ref.bed
OUTDIR=/home/FCAM/cpugliese/wns/03_bam2gvcf/04_n-amer_pd_vcf2
NAME=n-amer-pd_snp-count2

## run script (ploidy set to 1)
cd $OUTDIR
gatk --java-options "-Xmx4g" GenotypeGVCFs \
   -R $REF \
   -V gendb://$GENDBI \
   -all-sites \
   -ploidy 1 \
   -L $INTLIST \
   -O $NAME.vcf.gz \
       
########### script end