#!/usr/bin/env bash

#unzipping the files
gunzip abn26_1.fastq.gz abn26_2.fastq.gz

##performing fastqc analysis
fastqc abn26_1.fastq abn26_2.fastq -o ../results/fastqc_output

##visualizing the output
firefox *.html
