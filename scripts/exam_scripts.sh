echo "Beginning Analysis... "
#iii)
mkdir fastqc_results
fastqc ../exam_data/*.fastq.gz -o fastqc_results
#QUESTION 2
mkdir trimming && cd trimming
trimmomatic PE -phred33 ../../exam_data/abn26_1.fastq.gz ../../exam_data/abn26_2.fastq.gz  \
              abn26_1.trimmed.fastq.gz abn26_1.untrimmed.fastq.gz \
              abn26_2.trimmed.fastq.gz abn26_2.untrimmed.fastq.gz \
              LEADING:3  TRAILING:3 SLIDINGWINDOW:4:20
cd ../
#post_trim fastqc
mkdir posttrim_fastqc_results
fastqc trimming/*.trimmed.fastq.gz -o posttrim_fastqc_results
##QUESTION 3
mkdir alignment && cd alignment/
#indexing
bwa index ../../exam_data/Pfalciparum.genome.fasta
#alignment
bwa mem ../../exam_data/Pfalciparum.genome.fasta ../../exam_data/abn26_1.fastq.gz ../../exam_data/abn26_2.fastq.gz > abn26.sam
# convert sam to bam
samtools view -b abn26.sam -o abn26.bam
#sorting
samtools sort abn26.bam -o abn26_sorted.bam
#Markduplicates
picard MarkDuplicates I=abn26_sorted.bam O=abn26.markdup.bam M=abn26.metrics.txt
#Indexing the markdup output file
samtools index abn26.markdup.bam
###QUESTION 4
# Variant calling
bcftools mpileup -f ../../exam_data/Pfalciparum.genome.fasta abn26.markdup.bam | bcftools call -m -o abn26.vcf
#snps only
bcftools query -f'%CHROM %POS %ID %QUAL %REF %ALT\n' -i 'type="snp"' abn26.vcf > snp_only.vcf
###since I worked from alignment folder i COPIED 'VARIANT CALLING' ALL OUTPUT TO VARIANT CALLING FOLDER.
mkdir ../variant_calling
cp *.vcf ../variant_calling/
echo "#########Completed analysis#########"
