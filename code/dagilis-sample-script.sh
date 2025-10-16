# This script takes three inputs and returns a set of commands to go from raw reads to mapped and filtered bams and called gvcfs.
# It is called as: sh raw2gvcf_pipe.sh -r <reference> -s <file with list of individuals to map> -t <location of annotated table with all samples>
# The annotated samples table must include the name of the sample as the first column, the individual name as the second column, and the location of raw fastq's in the third and fourth columns
# Current version only works for short read illumina data, so make sure you call appropriately.

while getopts r:s:t: option
do
    case "${option}"
            in
            r) reference=${OPTARG};;
            s) toMap_file=${OPTARG};;
            t) samples_table=${OPTARG};;
esac
done

inds=($(cat $toMap_file))

picard_loc="/isg/shared/apps/picard/picard-tools-2.9.2/"
tmp_dir="/scratch/adagilis/TMP"

for ind in ${inds[@]}; do
      samples=($(awk -v i=$ind '$2==i' $samples_table | wc))
         echo "##${ind}"
         echo "module load bwa"
         echo "module load GATK"
         echo "module load bbmap"
         echo "module load samtools"
         echo "export _JAVA_OPTIONS=-Djava.io.tmpdir=/scratch/adagilis/TMP"
         #Trim reads:
                 awk -v i=$ind '$2==i{printf "bbduk.sh ref=~/res/adapters.fa t=10 qtrim=rl maq=10 trimq=15 in="  $3 " out=.trimmed/" $1 "_1.fastq";if ($4!="-") print " in2=" $4 " out2=.trimmed/" $1 "_2.fastq tpe tbo"; else printf "\n"}' $samples_table
         # Map reads using bwa. The read group info (RG) requires the table to contain entries on the platform (column 6), and library (column 7)
                 awk -v i=$ind -v ref=$reference '$2==i{printf "bwa mem " ref " ./trimmed/" $1 "_1.fastq "; if($4!="-") printf "./trimmed/" $1 "_2.fastq"; print " -R \"@RG\\tID:"$1"\\tSM:"$2"\\tPL:"$6"\\tLB:"$7"\" | samtools view -Sb -o " $1 ".bam"}' $samples_table
         # Move to bam folder and rename:
                 awk -v i=$ind '$2==i{print "mv " $1 ".bam ./bams/" i ".bam"}'  $samples_table
         #Clean bam:
                 echo "java -Djava.io.tmpdir=${tmp_dir} -jar ${picard_loc}picard.jar CleanSam I=./bams/${ind}.bam O=./bams/${ind}.clean.bam QUIET=true COMPRESSION_LEVEL=0"
         #Sort bam:
                 echo "java -Djava.io.tmpdir=${tmp_dir} -jar ${picard_loc}picard.jar SortSam I=./bams/${ind}.clean.bam O=./bams/${ind}.sorted.bam SORT_ORDER=coordinate CREATE_INDEX=true"
         #Mark duplicates:
                 echo "java -Djava.io.tmpdir=${tmp_dir} -jar ${picard_loc}picard.jar MarkDuplicates I=./bams/${ind}.sorted.bam O=./bams/${ind}.deduped.bam ASSUME_SORTED=true CREATE_INDEX=true M=/labs/Dagilis/Projects/WNS/logs/${ind}.dedup.metric.txt"
         #Call Haplotype GVCF:
                 echo "gatk --java-options \"-Xmx12g -Djava.io.tmpdir=${tmp_dir}\" HaplotypeCaller -R ${reference} --sample-ploidy 1 -I ./bams/${ind}.deduped.bam -O ./gvcfs/${ind}.gvcf -ERC GVCF"
done