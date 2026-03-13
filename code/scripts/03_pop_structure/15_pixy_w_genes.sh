#!/bin/bash
#SBATCH --job-name=pixy
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=3G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

hostname
date

source /home/FCAM/cpugliese/.bashrc
conda activate pixyenv

## variables
VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/01_all-samples/ploidy-1/pd_ploidy-1.vcf.gz
POP=../02_ids-by-pcansd-pops.txt
BED=/home/FCAM/cpugliese/wns/02_raw-data/pd_data/pd_ref/pd_gene_ref.bed
OUTDIR=/home/FCAM/cpugliese/lab_wns/08_pixy/01_n-amer-no-clones/06_by-pops_genes
PREFIX=n-amer-no-clones_by-pops_genes

cd $OUTDIR

# using pixy version 2.0.0.beta14
pixy --stats pi dxy fst tajima_d \
    --vcf $VCF \
    --pop $POP \
    --bed_file $BED \
    --n_cores 4 \
    --output_prefix $PREFIX \
    --output_folder $OUTDIR \
    --fst_type hudson

conda deactivate

########### script end