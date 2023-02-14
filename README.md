# FLAQ-MPX (Florida Assembly Quality - Monkeypox) (Under further development)
FL BPHL's Monkeypox (MPX) analysis pipeline for Illumina paired-end, whole-genome tiled-amplicon data. 

## About
FLAQ-MPX was developed to analyze Illumina paired-end, whole-genome tiled-amplicon data (i.e., [ARTIC/PrimalSeq based protocol](https://www.protocols.io/view/monkeypox-virus-multiplexed-pcr-amplicon-sequencin-5qpvob1nbl4o/v4)) from MPX-positive clinical specimens. The pipeline generates consensus assemblies along with reports including read/mapping/assembly quality metrics and quality flags to support screening samples prior to submissions to public repositories (e.g., GISAID, NCBI Genbank). The current version will run only on [HiPerGator](https://www.rc.ufl.edu/about/hipergator/)(HPG) using local Singularity containers for each pipeline process.

## Dependencies
- Python3
- Singularity/Apptainer
- [iVar](https://github.com/andersen-lab/ivar)
- Git

To load python3 into your current environment on HiPerGator, either use `module load python` to get the lastest version of python or activate your base conda environment. For more information on how to set up your base conda environment on HPG, see the [HiPerGator Analysis Reference Guide](https://github.com/StaPH-B/southeast-region/tree/master/hipergator)).

Singularity/Apptainer will be loaded as a module during your job execution on HPG using the sbatch job script in this repository. 

The iVar Singularity container on HiPerGator does not run consistently. Instead, iVar can be installed via [conda](https://bioconda.github.io/recipes/ivar/README.html?highlight=ivar#package-package%20&#x27;ivar&#x27;). Activate your ivar conda environment with `conda activate ivar`.

Git is already installed in your HPG environment upon login.

## Usage

For first time use, clone this repository to a directory in blue on HPG, such as in /blue/bphl-\<state\>/\<user\>/repos/bphl-molecular/.
```
cd /blue/bphl-<state>/<user>/repos/bphl-molecular/
git clone https://github.com/BPHL-Molecular/flaq_mpx.git
```
For future use, update any changes to your local repository on HPG by navigating to the flaq_mpx repository and pulling any changes.
```
cd flaq_mpx/
git pull
```
To run the FLAQ-MPX pipeline, copy all files from the flaq_mpx local repository to your analysis folder. Make an input directory and copy your fastqs.
```
mkdir <analysis_dir>
cd <analysis_dir>
cp /blue/bphl-<state>/<user>/repos/bphl-molecular/flaq_mpx/* .
mkdir fastqs/
cp /path/to/fastqs/*.fastq.gz fastqs/
```
Rename your fastq files to the following format: sample_1.fastq.gz, sample_2.fastq.gz. See below for a helpful command to rename your R1 and R2 files.
```
cd fastqs/
for i in *_R1_001.fastq.gz; do mv -- "$i" "${i%[PATTERN to REMOVE]}_1.fastq.gz"; done
for i in *_R2_001.fastq.gz; do mv -- "$i" "${i%[PATTERN to REMOVE]}_2.fastq.gz"; done
```
Edit your sbatch job submission script to include your email to receive an email notification upon job END or FAIL. Replace ENTER EMAIL in `#SBATCH --mail-user=ENTER EMAIL` with your email address. Make sure there is no space between = and your email address. Edit additional sbatch parameters as needed to run your job succesfully, such as the length of time the job will run.

Submit your job.
```
sbatch sbatch_flaq_mpx.sh
```

## Main processes
- [Fastqc](https://github.com/s-andrews/FastQC)
- [Trimmomatic](https://github.com/usadellab/Trimmomatic)
- [BBDuk](https://jgi.doe.gov/data-and-tools/software-tools/bbtools/bb-tools-user-guide/bbduk-guide/)
- [BWA](https://github.com/lh3/bwa)
- [Samtools](https://github.com/samtools/samtools)
- [iVar](https://github.com/andersen-lab/ivar)

## Primary outputs

Outputs from each process for each individual sample can be found in a sample-specific subdirectory within the FLAQ-MPX analysis directory. Report.txt contains the main summary report with read/mapping/assembly quality metrics and quality flags to support screening samples prior to submissions to public repositories (e.g., GISAID, NCBI Genbank). Additional details can be found in the report outputs from each process. Final assemblies (.fasta) and variant files (.variant.tsv) are copied into the run directory for easier access for use in downstream analyses or for samples that require manual review.

```
analysis_dir/
|__ <date>_flaq_run/
     |__ report.txt
     |__ sample1/
     |__ sample2/
|__ assemblies/
|__ variants/
```

## Developed by:
[@SESchmedes](https://www.github.com/SESchmedes)<br />

Please email bphl16BioInformatics@flhealth.gov for questions and support.
