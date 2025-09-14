#!/bin/bash
#SBATCH --job-name=ploidy-1_joint-cal
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=6G
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
module load GATK/4.3.0.0

## define variables
REF=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pdestructans.fasta
GENDBI=/home/FCAM/cpugliese/wns-lab/gvcfs/02_consolidate-gvcfs/genomicsDBI
INTLIST=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pd_ref.bed
OUTDIR=/home/FCAM/cpugliese/wns-lab/gvcfs/03_joint-calling/ploidy-1
NAME=pd_ploidy-1

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