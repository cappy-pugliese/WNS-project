## testing zone
head n-amer-no-clones_by-year_dxy.txt | awk '{if($9 > 30000) print $9}'

awk '$6 !~ /NA/'

------------------------------------------------------------
## commands
### for dxy (>0)
cat n-amer-no-clones_by-year_dxy.txt | awk '{if($6 > 0) print $0}' > awk_n-amer-no-clones_by-year_dxy.txt

### for fst (just NAs)
cat n-amer-no-clones_by-year_fst.txt | awk '{if($6 !~ /NA/) print $0}' > awk_n-amer-no-clones_by-year_fst.txt

### for pi (>0 & NAs)
cat n-amer-no-clones_by-year_pi.txt | awk '{if($5 !~ /NA/ && $5 > 0) print $0}' > awk_n-amer-no-clones_by-year_pi.txt

cat n-amer-no-clones_by-year_pi.txt | awk '{if($5 !~ /NA/) print $0}' | wc -l

cat n-amer-no-clones_by-year_pi.txt | awk '{if($5 == 0) print $0}' | wc -l

### for tajima_d (just NAs)
cat n-amer-no-clones_by-year_tajima_d.txt | awk '{if($5 !~ /NA/) print $0}' > awk_n-amer-no-clones_by-year_tajima-d.txt

first: run fst with 10kb (cap at 50kb)
can also just set fst na's to 0 where pi and dxy = 0
we expect pi to be small

plotting
- x axis: window positioning (average for each position)
- y axis: Fst (or dxy)
- do 2006 vs the others, color by year (will probs have 8 graphs)

- average pi (sudo log??) across genome vs year
    - violin plot for windows