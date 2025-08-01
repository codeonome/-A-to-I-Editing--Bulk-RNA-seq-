#!/bin/bash                                                                                                                                                                          #SBATCH --job-name=jacusa2_AtoI_real_02                                                                                                                                              #SBATCH --mail-type=END,FAIL                                                                                                                                                         #SBATCH --mail-user=Apoorva.Sharma@nyulangone.org                                                                                                                                    #SBATCH --ntasks=1                                                                                                                                                                   
#SBATCH --cpus-per-task=8                                                                                                                                                           
#SBATCH --mem=32gb                                                                                                                                                                   
#SBATCH --time=12:00:00                                                                                                                                                              #SBATCH -p cpu_medium                                                                                                                                                                #SBATCH -o jacusa2_AtoI_02_%j.log                                                                                                                                                    #SBATCH -e jacusa2_AtoI_02_%j.err

module purge
module load java/1.8

BASEDIR="/gpfs/data/khodadadilab/home/temp/Di-Stefano-Lab-Assignment"
ALIGNDIR="$BASEDIR/Task1/04_aligned"
OUTDIR="$BASEDIR/Task1/jacusa2_output_real_02"
JAR="/gpfs/home/as18818/tools/JACUSA_v2.0.4.jar"   # ← no space
mkdir -p "$OUTDIR"

java -Xmx28G -jar "$JAR" call-2 \
  "$ALIGNDIR/A1_DMSO_1_Aligned.sortedByCoord.out.bam","$ALIGNDIR/A2_DMSO_2_Aligned.sortedByCoord.out.bam" \
  "$ALIGNDIR/A3_1D_dTAG_1_Aligned.sortedByCoord.out.bam","$ALIGNDIR/A4_1D_dTAG_2_Aligned.sortedByCoord.out.bam" \
  -P RF-FIRSTSTRAND \
  -B A2G,T2C \
  -r "$OUTDIR/jacusa2_AtoI.tsv" \    # output TSV
  -q 20 \
  -p 8

echo "done"
