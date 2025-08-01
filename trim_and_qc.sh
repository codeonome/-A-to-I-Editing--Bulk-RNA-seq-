#!/bin/bash
#SBATCH --job-name=fastp_trim
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=Apoorva.Sharma@nyulangone.org
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=8
#SBATCH --mem=40gb
#SBATCH --time=24:00:00
#SBATCH -p cpu_medium
#SBATCH -o fastp_%j.log
#SBATCH -e fastp_%j.err

module purge
module load fastp

# Define paths
BASEDIR="/gpfs/data/khodadadilab/home/temp/Di-Stefano-Lab-Assignment"
TRIMDIR="$BASEDIR/Task1/02_trimmed_fastp"
REPORTDIR="$BASEDIR/Task1/04_fastp_reports"

mkdir -p "$TRIMDIR" "$REPORTDIR"

cd "$BASEDIR"

# Define sample names (no _R1/_R2 suffix)
SAMPLES=("A1_DMSO_1" "A2_DMSO_2" "A3_1D_dTAG_1" "A4_1D_dTAG_2")

echo "=== Trimming with fastp ==="

for SAMPLE in "${SAMPLES[@]}"; do
  echo "Processing $SAMPLE..."

  fastp \
    -i "${SAMPLE}_R1.fastq.gz" \
    -I "${SAMPLE}_R2.fastq.gz" \
    -o "$TRIMDIR/${SAMPLE}_R1_trimmed.fastq.gz" \
    -O "$TRIMDIR/${SAMPLE}_R2_trimmed.fastq.gz" \
    --html "$REPORTDIR/${SAMPLE}_fastp.html" \
    --json "$REPORTDIR/${SAMPLE}_fastp.json" \
    --thread 8 \
    --length_required 35 \
    --qualified_quality_phred 20 \
    --detect_adapter_for_pe \
    --trim_front1 0 --trim_front2 0 \
    --trim_tail1 0 --trim_tail2 0 \
    --cut_front --cut_tail

done

echo "fastp trimming complete. Trimmed files in: $TRIMDIR"
