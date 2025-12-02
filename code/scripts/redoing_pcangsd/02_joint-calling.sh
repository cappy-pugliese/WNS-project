#!/bin/bash
#SBATCH --job-name=joint-cal
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=6G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

hostname
date

## load modules
module load GATK/4.3.0.0

## define variables
REF=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pdestructans.fasta
GENDBI=/home/FCAM/cpugliese/lab_wns/04_gvcfs/02_consolidate-gvcfs/02_only-pd
INTLIST=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pd_ref.bed
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/only_pd
NAME=only-pd

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