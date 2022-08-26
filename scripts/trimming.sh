#!/user/bin/env bash
##trimming using trimmomatic
trimmomatic PE -phred33 abn26_1.fastq abn26_2.fastq ../results/abn26_1.trimmed.fastq ../results/abn26_1.untrimmed.fastq ../results/abn26_2.trimmed.fastq ../results/abn26_2.untrimmed.fastq LEADING:3  TRAILING:3 SLIDINGWINDOW:4:20

##trimming with sickle tool
#sickle pe -f abn26_1.fastq -r abn26_2.fastq -t sanger -o trimmed_abn26_1.fastq -p trimmed_abn26_2.fastq -s trimmed_single_file1.fastq
