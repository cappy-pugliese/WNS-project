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
UNFILTERED_VCF1_PATH=/home/FCAM/cpugliese/lab_wns/05_vcfs/01_orig-vcfs/03_only-n-amer-pd/n-amer_ploidy1_pd.vcf.gz
UNFILTERED_VCF1=n-amer_ploidy1_pd.vcf.gz
FILTERED_VCFS_PATH=/home/FCAM/cpugliese/lab_wns/05_vcfs/03_filtered-vcfs
FILTERED_VCF1=n-amer-pd-only_filtered.vcf.gz
FILTERED_VCF2=snp-count_n-amer_no-clones_filtered.vcf.gz
FILTERED_VCF3=n-amer-no-washington.vcf.gz

NAMER_VCFS_PATH=/home/FCAM/cpugliese/wns/03_bam2gvcf/04_n-amer_pd_vcf2
UNFILTERED_VCF2=ONLY_n-amer_no-clones.vcf.gz
FILTERED_VCF2_2=ONLY_n-amer_no-clones_filtered.vcf.gz

cd $OUTDIR

#echo "begining SNP count..." > snp_counts2.txt

#echo -e "Unfiltered North American VCF: $UNFILTERED_VCF1 \nSNP count: $(bcftools view -H -v snps $UNFILTERED_VCF1_PATH | wc -l)" >> snp_counts2.txt

#echo -e "Filtered North American VCF: $FILTERED_VCF1 \nSNP count: $(bcftools view -H -v snps $FILTERED_VCFS_PATH/$FILTERED_VCF1 | wc -l)" >> snp_counts2.txt

#echo -e "Unfiltered N-amer no clones: $UNFILTERED_VCF2 \nSNP count: $(bcftools view -H -v snps $NAMER_VCFS_PATH/$UNFILTERED_VCF2 | wc -l)" >> snp_counts2.txt

#echo -e "Filtered N-amer no clones: $FILTERED_VCF2_2 \nSNP count: $(bcftools view -H -v snps $NAMER_VCFS_PATH/$FILTERED_VCF2_2 | wc -l)" >> snp_counts2.txt

#echo -e "Filtered no clones: $FILTERED_VCF2 \nSNP count: $(bcftools view -H -v snps $FILTERED_VCFS_PATH/$FILTERED_VCF2 | wc -l)" >> snp_counts2.txt

echo "" >> snp_counts2.txt
echo "redoing no Washington..." >> snp_counts2.txt
echo -e "Filtered no Washington: $FILTERED_VCF3 \nSNP count: $(bcftools view -H -v snps $FILTERED_VCFS_PATH/$FILTERED_VCF3 | wc -l)" >> snp_counts2.txt

########### script end