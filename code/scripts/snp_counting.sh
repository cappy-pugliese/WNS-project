#!/bin/bash
#SBATCH --job-name=snp_count
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

## load modules
module load bcftools/1.19

## variables
OUTDIR=/home/FCAM/cpugliese/lab_wns/05_vcfs
UNFILTERED_VCF1_PATH=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/01_all-samples/ploidy-1/pd_ploidy-1.vcf.gz
UNFILTERED_VCF1=pd_ploidy-1.vcf.gz
UNFILTERED_VCF2_PATH=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/02_only-pd/01_ploidy1/only-pd.vcf.gz
UNFILTERED_VCF2=only-pd.vcf.gz
FILTERED_VCFS_PATH=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
FILTERED_VCF1=pd_filtered.vcf.gz
FILTERED_VCF2=only-pd-ploidy1-filtered.vcf.gz

cd $OUTDIR
echo "begining SNP count..." > snp_counts.txt

echo "$UNFILTERED_VCF1 SNP count: $(bcftools view -H -v snps $UNFILTERED_VCF1_PATH | wc -l)" >> snp_counts.txt

echo "$FILTERED_VCF1 SNP count: $(bcftools view -H -v snps $FILTERED_VCFS_PATH/$FILTERED_VCF1 | wc -l)" >> snp_counts.txt

echo "$UNFILTERED_VCF2 SNP count: $(bcftools view -H -v snps $UNFILTERED_VCF2_PATH | wc -l)" >> snp_counts.txt

echo "$FILTERED_VCF2 SNP count: $(bcftools view -H -v snps $FILTERED_VCFS_PATH/$FILTERED_VCF2 | wc -l)" >> snp_counts.txt


########### script end