#!/bin/bash
#SBATCH --job-name=pixy
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=5G
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
VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/n-amer-no-clones_filtered.vcf.gz
POP=01_ids-by-year.txt
OUTDIR=/home/FCAM/cpugliese/lab_wns/08_pixy/01_n-amer-no-clones/
PREFIX=n-amer-no-clones_by-year

# try again using an unfiltered vcf and seeing if it is able to find invariants now
# if not, message andrius

cd $OUTDIR

# using pixy version 2.0.0.beta14
pixy --stats pi dxy fst tajima_d \
    --vcf $VCF \
    --pop $POP \
    --window_size 1000 \
    --n_cores 2 \
    --output_prefix $PREFIX \
    --output_folder $OUTDIR \


conda deactivate

########### script end

--populations
# headerless, sep by tabs
# column names:
# SampleID Population

pixy --help
# tells you required arguments
