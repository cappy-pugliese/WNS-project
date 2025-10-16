#!/bin/bash
#SBATCH --job-name=consol_GVCF
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 5
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
module load GATK/4.3.0.0

#### point to paths
INDIR=/home/FCAM/cpugliese/wns-lab/gvcfs/01_haplotypecaller/01_run_all_bams
OUTDIR=/home/FCAM/cpugliese/wns-lab/gvcfs/02_consolidate-gvcfs/genomicsDBI
INTLIST=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pd_ref.bed

cd $INDIR
gatk --java-options "-Xmx4g -Xms4g" \
       GenomicsDBImport \
       --genomicsdb-workspace-path $OUTDIR \
       --sample-name-map $INDIR/Pd_sample_map.txt \
       --reader-threads 5 \
       -L $INTLIST
       
########### script end