#!/bin/bash
#SBATCH --job-name=consol_GVCF
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 5
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

hostname
date

## load modules
module load GATK/4.3.0.0

#### point to paths
INDIR=/home/FCAM/cpugliese/lab_wns/04_gvcfs/01_haplotypecaller/02_only-pd
OUTDIR=/home/FCAM/cpugliese/wns/03_bam2gvcf/04_n-amer_pd_vcf2/01_consol_gvcf
INTLIST=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pd_ref.bed

cd $INDIR
gatk --java-options "-Xmx4g -Xms4g" \
       GenomicsDBImport \
       --genomicsdb-workspace-path $OUTDIR \
       --sample-name-map $INDIR/n-amer_Pd_sample_map.txt \
       --reader-threads 5 \
       -L $INTLIST
       
########### script end