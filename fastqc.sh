#!/bin/bash
#SBATCH --job-name=FastQC
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=Apoorva.Sharma@nyulangone.org
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=32gb
#SBATCH --time=12:00:00
#SBATCH -p cpu_medium
#SBATCH -o fastqc_%j.log
#SBATCH -e fastqc_%j.err

# Load required modules
module purge
module load fastqc
module load multiqc

# Define directories
RAWDIR="/gpfs/data/khodadadilab/home/temp/Di-Stefano-Lab-Assignment"
OUTDIR="$RAWDIR/Task1/01_fastqc_raw"

echo "Running FastQC on raw FASTQ files..."
echo "Raw input directory: $RAWDIR"
echo "Output directory: $OUTDIR"

# Create output directory if not exists
mkdir -p "$OUTDIR"

# Run FastQC
fastqc "$RAWDIR"/*.fastq.gz -o "$OUTDIR" -t 8

# Run MultiQC to aggregate reports
#cd "$OUTDIR"
#multiqc . -o . --title "Raw_Reads_QC"

#echo "FastQC and MultiQC completed."
