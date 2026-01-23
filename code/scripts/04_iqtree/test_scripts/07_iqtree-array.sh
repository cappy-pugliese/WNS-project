#!/bin/bash
#SBATCH --job-name=array-test
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 4
#SBATCH --mem=3G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH --output=out/array_%A_%a.out
#SBATCH --error=err/array_%A_%a.err
#SBATCH --array=1-10%2

########### script start

hostname
date

## load modules
source ~/.bashrc
module load bcftools/1.19
module load iqtree/2.2.2

## set variables
NAMEFILE=test2_names.txt
WIND=/home/FCAM/cpugliese/wns/06_iqtree/01_text-files
TMP=/home/FCAM/cpugliese/wns/06_iqtree/02_test-runs/02_test-run/test_2

cd $TMP
SCRIPT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" "$WIND/$NAMEFILE")

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Running task ${SLURM_ARRAY_TASK_ID}: $SCRIPT"

bash "$SCRIPT"

########### script end