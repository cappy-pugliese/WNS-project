#!/bin/bash
#SBATCH --job-name=iqtree
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=3G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --mail-type=ALL
#SBATCH --mail-user=caprina.pugliese@uconn.edu
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

## modules needed:
module load bcftools/1.20
module load iqtree/3.0.1

## set variables
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree
VCF=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs/

cd $OUTDIR

## commands to run
bcftools view -r NW_020167520.1:1-10001 pd_filtered.vcf.gz > NW_020167520.1_0_wnd10000.vcf
# ^^this command currently does not work
# need to figure out how to give it the index file
plink2 --vcf NW_020167520.1_0_wnd10000.vcf --snps-only --allow-extra-chr --export phylip-phased --out NW_020167520.1_0_wnd10000
rm NW_020167520.1_0_wnd10000.vcf
iqtree3 -redo -pre NW_020167520.1_0_wnd10000 -nt AUTO -ntmax 4 -bb 1000 -s NW_020167520.1_0_wnd10000.phy

########### script end

