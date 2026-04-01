#This script takes the commands produced by raw2gvcf.sh and splits them into individual jobs per sample. Allows for quick modification of parameters for all of the runs.
awk '{if(gsub(/##/,"")) {name=$0;
        print "#!/bin/bash" > name".sbatch";
        print "#SBATCH -N 1" >> name".sbatch";
        print "#SBATCH -n 1" >> name".sbatch";
        print "#SBATCH -c 4" >> name".sbatch";
        print "#SBATCH --qos=general" >> name".sbatch";
        print "#SBATCH --partition=general" >> name".sbatch";
        print "#SBATCH --ntasks 1" >> name".sbatch";
        print "#SBATCH -t 00:20:00 " >> name".sbatch";
        print "#SBATCH --mem 3G " >> name".sbatch";
        print "#SBATCH -o logs/"name ".%j.out" >> name".sbatch";
        print "#SBATCH -e logs/"name ".%j.err" >> name".sbatch";
        print "#SBATCH -J " name >> name".sbatch";}
        else {print >> name".sbatch";}}' $1