## testing zone

```{bash}
head n-amer-no-clones_by-year_dxy.txt | awk '{if($9 > 30000) print $9}'

awk '$6 !~ /NA/'
```

------------------------------------------------------------------------

## commands

### for dxy (\>0)

```{bash}
cat n-amer-no-clones_by-year_dxy.txt | awk '{if($6 > 0) print $0}' > awk_n-amer-no-clones_by-year_dxy.txt
```

### for fst (just NAs)

```{bash}
cat n-amer-no-clones_by-year_fst.txt | awk '{if($6 !~ /NA/) print $0}' > awk_n-amer-no-clones_by-year_fst.txt
```

### for pi (\>0 & NAs)

```{bash}
cat n-amer-no-clones_by-year_pi.txt | awk '{if($5 !~ /NA/ && $5 > 0) print $0}' > awk_n-amer-no-clones_by-year_pi.txt

cat n-amer-no-clones_by-year_pi.txt | awk '{if($5 !~ /NA/) print $0}' | wc -l

cat n-amer-no-clones_by-year_pi.txt | awk '{if($5 == 0) print $0}' | wc -l
```

### for tajima_d (just NAs)

```{bash}
cat n-amer-no-clones_by-year_tajima_d.txt | awk '{if($5 !~ /NA/) print $0}' > awk_n-amer-no-clones_by-year_tajima-d.txt
```

first: run fst with 10kb (cap at 50kb) can also just set fst na's to 0 where pi and dxy = 0 we expect pi to be small

plotting - x axis: window positioning (average for each position) - y axis: Fst (or dxy) - do 2006 vs the others, color by year (will probs have 8 graphs)

-   average pi (sudo log??) across genome vs year
    -   violin plot for windows

### Redoing by genes instead of by window size:

```{bash}
cat pdestructans.gtf | grep "^NW" | awk '{print $1, $2, $3, $4, $5, $10, $12, $14, $16}' | awk '{gsub(/""/,"NA",$7); print}' | awk '{gsub(/;/,""); print}' | awk '{gsub(/"/,""); print}' | awk '{gsub(/Gene/,"NA",$9); print}' > pd_gtf-info.txt


cat pd_gtf-info.txt | awk '{print $1, $3, $4, $5, $6}' | grep "gene" > pd_gene_info.txt
# want to print out the gene rows

cat pd_gene_ref.bed | awk -v OFS='\t' '{print $1, $2, $3}' > pd_gene_ref.bed



cat pd_gtf-info.txt | awk -v OFS='\t' '{print $1, $3, $4, $5, $6}' | grep "exon" > pd_exon_info.txt

cat pd_exon_info.txt | awk -v OFS='\t' '{print $1, $3, $4}' > pd_exon_ref.bed

cat pdestructans.gff | grep "^NW" | awk '{print $3}' | uniq
```