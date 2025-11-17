#!/bin/bash
#SBATCH --job-name=gen_cmds
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 2
#SBATCH --mem=3G
#SBATCH --partition=general
#SBATCH --qos=general
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

########### script start

## variables
INDIR=/home/FCAM/cpugliese/wns/06_iqtree/01_text-files/
OUTDIR=/home/FCAM/cpugliese/wns/06_iqtree/02_test-runs/02_test-run/
PIPE=/home/FCAM/cpugliese/wns/06_iqtree/scripts/03_pipe2slurm.sh

cd $OUTDIR
cat $INDIR/test_cmds.txt | $PIPE

########### script end