#!/bin/bash
#SBATCH --job-name=plink
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=5G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err

########### script start

## set variables
VCF=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/01_filtered-vcfs/ALL_filtered_branchlengths2.vcf.gz
OUTNAME=ALL_filtered_branchlengths2_plink
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/03_fixing-branchlenghts/02_plink

cd $OUTDIR

plink2 \
--vcf $VCF \
--snps-only \
--geno 0.1 \
--mind 0.5 \
--allow-extra-chr \
--chr-set -83 \
--export phylip \
--out $OUTNAME

########### script end

## in theory this script should work, but for some reason it's running into an error

# Error: --export phylip: 0-based variant #62 has allele code(s) outside {A,C,G,T,missing}. (Did you forget --snps-only?)
    ## this error is weird because I specified snps only _and_ it says that I specified snps only sooooo... idk what's going on here but this code worked previously so.

# Pretty sure the script is not working because of the vcf
# I think changing the -m and -M might have messed it up somehow
# I think it needs to be biallelic to work with plink

