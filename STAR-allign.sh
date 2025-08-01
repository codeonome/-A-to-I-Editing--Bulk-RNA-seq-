#!/bin/bash

#SBATCH --job-name=star_align
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=Apoorva.Sharma@nyulangone.org
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=60gb
#SBATCH --time=24:00:00
#SBATCH -p cpu_medium
#SBATCH -o star_align_%j.log
#SBATCH -e star_align_%j.err

module purge
module load star
module load samtools

# Define paths
BASEDIR="/gpfs/data/khodadadilab/home/temp/Di-Stefano-Lab-Assignment"
TRIMDIR="$BASEDIR/Task1/02_trimmed_fastp"
ALIGNDIR="$BASEDIR/Task1/04_aligned"
REFDIR="/gpfs/home/as18818/ref/hg38"
GENOME_INDEX="$REFDIR/star_index"

mkdir -p "$ALIGNDIR"
cd "$BASEDIR"

# Define sample names (no _R1/_R2 suffix)
SAMPLES=("A1_DMSO_1" "A2_DMSO_2" "A3_1D_dTAG_1" "A4_1D_dTAG_2")

echo "=== STAR Alignment ==="

for SAMPLE in "${SAMPLES[@]}"; do
  echo "Aligning sample: $SAMPLE"

  STAR \
    --runThreadN 8 \
    --genomeDir "$GENOME_INDEX" \
    --readFilesIn "$TRIMDIR/${SAMPLE}_R1_trimmed.fastq.gz" "$TRIMDIR/${SAMPLE}_R2_trimmed.fastq.gz" \
    --readFilesCommand zcat \
    --outFileNamePrefix "$ALIGNDIR/${SAMPLE}_" \
    --outSAMtype BAM SortedByCoordinate \
    --quantMode TranscriptomeSAM GeneCounts \
    --outSAMstrandField intronMotif \
    --twopassMode Basic \
    --outSAMattributes NH HI AS nM MD

  echo "Indexing BAM for $SAMPLE"
  samtools index "$ALIGNDIR/${SAMPLE}_Aligned.sortedByCoord.out.bam"

done

echo "STAR alignment complete. Sorted BAMs in: $ALIGNDIR"
