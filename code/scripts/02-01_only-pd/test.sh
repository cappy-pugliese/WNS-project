#!/bin/bash

NAME=ploidy1
OUTPUT_DIR=.

if [ -f "$OUTPUT_DIR/$NAME.TsTv.summary" ]; then
    Ts=$(grep "Ts" $NAME.TsTv.summary | awk '{print $2}')
    Tv=$(grep "Tv" $NAME.TsTv.summary | awk '{print $2}')
    TsTv_RATIO=$(echo "$Ts $Tv" | awk '{print $1 / $2}')
    echo "Ts/Tv ratio: $TsTv_RATIO" >> $OUTPUT_DIR/$NAME.summary.txt
else
    echo "Ts/Tv ratio: N/A (No SNPs or calculation failed)" >> $OUTPUT_DIR/$NAME.summary.txt
fi