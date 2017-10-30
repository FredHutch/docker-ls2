# docker-ls2
Basic Ubuntu-based docker container for batch use.

ls2 = Life-sciences Software Stack

This container was built to duplicate our datacenter software stack so researchers can continue to use the same tool (versions) that are available on our HPC cluster.

Use instructions will be posted soon.

Initially, this container is intended for AWS Batch use.

All packages are built using EasyBuild with the foss-2016b toolchain.

Software packages included:

Python 2: 2.7.12 (Ubuntu 16.04 package)
Python 3
R (w/Bioconductor)
Java: 1.8.0u92
Perl: 5.24.1
BEDTools - 2.26.0
SAMtools: 1.6
BCFtools: 1.6
BWA: 0.7.15
TopHat: 2.1.1
FastQC: 0.11.5
annovar: 2016Feb01
SRA-Toolkit: 2.8.0
Bowtie2: 2.2.9
Beast: 1.8.4
Beast: 2.4.7
picard: 2.13.2
FastTree: 2.1.9
Homer: v4.9
VCFtools: 0.1.15
bcl2fastq: 2.20.0
MUSCLE: 3.8.31
kallisto: 0.43.1
