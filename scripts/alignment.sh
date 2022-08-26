#indexing
bwa index Pfalciparum.genome.fasta
#alignment
bwa mem Pfalciparum.genome.fasta abn26_1.fastq abn26_2.fastq > abn26.sam
# convert sam to bam
samtools view -b abn26.sam -o abn26.bam
#sorting
samtools sort abn26.bam -o abn26_sorted.bam
#Markduplicates
picard MarkDuplicates I=abn26_sorted.bam O=abn26.markdup.bam M=abn26.metrics.txt
#Indexing the markdup output file
samtools index abn26.markdup.bam
#gnerating stats file
samtools stats abn26.markdup.bam > abn26.markdup.stats
#generating stats plots
##conda install -c bioconda samtools gnuplot
plot-bamstats -p abn26_plot abn26.markdup.stats
