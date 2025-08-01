# A-to-I RNA Editing Analysis from Bulk RNA-Sequencing Data
# Background


We hypothesized that our protein of interest, ILF3, binds to ADAR1 and regulates its enzymatic activity. ADAR1 catalyzes adenosine-to-inosine (A-to-I) conversions in double-stranded RNAs. To test this hypothesis, we used a degron system to degrade ILF3 for 24 hours, followed by stranded RNA sequencing.
Experimental Design
• Treatment conditions: Control (DMSO-treated) vs. ILF3-degraded (dTAG-treated)
• Replicates: Two biological replicates per condition
• Data: Stranded RNA-seq FASTQ files 
# Analysis Approach

Since inosines are structurally similar to guanosines, RNA editing events appear as A-to-G mismatches in sequencing data. We used JACUSA2 with stranded analysis to:
1. Compare A-to-I editing events between conditions
2. Calculate the ratio of edited vs. non-edited reads for each event
3. Perform statistical comparison using Wilcoxon test

# Complete code and/or pipeline used for the analysis and figure generation
# ILF3 / A-to-I Editing & H3K27ac Super-Enhancer Analysis  
# The raw fastq files were processed using the following scripts:
- fastqc.sh
- Trim_and_qc.sh
- STAR_align.sh
# The alignment files were used for find A-I editiing:
- jacusa2_02.sh

Result: (box plot showing editing ratios)
