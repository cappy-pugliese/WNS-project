#!/bin/bash

# Check if the correct number of arguments is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_vcf_file> <output_name>"
    exit 1
fi

## variables
INPUT_VCF=$1
NAME=$2
OUTPUT_DIR=/home/FCAM/cpugliese/lab_wns/05_vcfs/02_stats/03_only-pd/02_vcfstats/02_ploidy2/

# Count the total number of variants
TOTAL_VARIANTS=$(bcftools view -H $INPUT_VCF | wc -l)
echo "Total variants: $TOTAL_VARIANTS" > $OUTPUT_DIR/$NAME.summary.txt

# Count the number of SNPs
SNPS=$(bcftools view -H -v snps $INPUT_VCF | wc -l)
echo "SNPs: $SNPS" >> $OUTPUT_DIR/$NAME.summary.txt

# Count the number of INDELs
INDELS=$(bcftools view -H -v indels $INPUT_VCF | wc -l)
echo "INDELs: $INDELS" >> $OUTPUT_DIR/$NAME.summary.txt

# Calculate Transition/Transversion ratio
bcftools view -v snps $INPUT_VCF | vcftools --vcf - --TsTv-summary --out $OUTPUT_DIR/$NAME > $NAME.log
if [ -f "$OUTPUT_DIR/$NAME.TsTv.summary" ]; then
    TsTv_RATIO=$(grep "Ts/Tv ratio" $OUTPUT_DIR/$NAME.log | awk '{print $3}')
    echo "Ts/Tv ratio: $TsTv_RATIO" >> $OUTPUT_DIR/$NAME.summary.txt
else
    echo "Ts/Tv ratio: N/A (No SNPs or calculation failed)" >> $OUTPUT_DIR/$NAME.summary.txt
fi

# Generate allele frequency spectrum
vcftools --vcf $INPUT_VCF --freq --out $OUTPUT_DIR/$NAME.allele_freq

echo "Analysis complete. Results are in the $OUTPUT_DIR directory."
