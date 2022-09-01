#!/bin/bash
#SBATCH --account=bphl-umbrella
#SBATCH --qos=bphl-umbrella
#SBATCH --job-name=flaq_mpx
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=ENTER EMAIL
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=15
#SBATCH --mem=100gb
#SBATCH --time=3-00
#SBATCH --output=flaq_mpx.%j.out
#SBATCH --error=flaq_mpx.%j.err

#Run script/command and use $SLURM_CPUS_ON_NODE
module load singularity

python flaq_mpx.py fastqs/ --primer_bed primers/MPXV.primer.bed --lib_frag frag --threads $SLURM_CPUS_ON_NODE --ref_fasta reference/MPXV.reference.fasta --ref_gff reference/MPXV.gff3 
