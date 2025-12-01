#!/bin/bash
#SBATCH --job-name=plink
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
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
#using plink2.0 alpha (oct19 linux 64bit intel build)

## set variables
INDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/plink_files/03_plink-w-filtered-vcf

cd $OUTDIR

plink2 --vcf $INDIR/pd_filtered.vcf.gz \
--make-bed \
--double-id \
--allow-extra-chr \
--maf 0.05 \
--geno 0.1 \
--mind 0.5 \
--indep-pairwise 10kb 1000 .5 \
--out filtered_vcf_plink

########### script end


Error: --indep-pairwise window-increment must be 1 when window size is in
kilobase units.
For more info, try "plink2 --help <flag name>" or "plink2 --help | more".