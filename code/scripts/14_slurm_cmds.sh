#!/bin/bash
#SBATCH --job-name=gen_cmds
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

## variables
INDIR=/home/FCAM/cpugliese/wns/06_iqtree
OUTDIR=/home/FCAM/cpugliese/lab_wns/07_iqtree/01_genWind/02_Cappy-cmds
PIPE=/home/FCAM/cpugliese/wns/06_iqtree/scripts/03_pipe2slurm.sh

cd $OUTDIR
cat $INDIR/gen_cmds.txt | $PIPE
## ^^ would i do it this way? or would i do it similar to the command last time and do `$PIPE $INDIR/gen_cmds.txt`?

## making a file executable
# u is for user, x is for executable
chmod u+x <file>