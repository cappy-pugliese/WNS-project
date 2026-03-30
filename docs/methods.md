# Project methods (organizing)

## Data collection
This data was compiled from the NCBI database for *P. destructans* whole genome sequence samples. (add more info obviously)

## Sequence Mapping
andrius did most of this so figure out what was done, especially for generating the bams

## Varient calling and filtering
GATK pipeline (GATK/4.3.0.0)
1. Call variants: Haplotype caller
2. Consolidate GVCFs: GenomicsDBImport
3. Joint-call Cohort: GenotypeGVCFs
    - set ploidy to 1
4. bcftools view (bcftools/1.9)
    bcftools view -S $SAMPLES \
    -i 'QUAL>20' \
    -i 'MAF>0.05' \
    -v snps \

## PCAngsd
1. plink filtering (plink2.0 alpha (oct19 linux 64bit intel build))
    --make-bed \
    --double-id \
    --allow-extra-chr \
    --maf 0.05 \
    --geno 0.1 \
    --mind 0.5 \
2. pcangsd

## Algatr
1. plink again to get ld pruned:
    --make-bed \
    --double-id \
    --allow-extra-chr \
    --maf 0.05 \
    --geno 0.1 \
    --mind 0.5 \
    --indep-pairwise 1000 100 .5 \
    --set-all-var-ids @:#\$r,\$a \
2. followed algatr tutorial
    - TESS
    - MMRR
    - GDM
    - Wingen

## IQtree
iqtree/2.2.2