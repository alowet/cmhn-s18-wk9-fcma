#!/bin/bash
#SBATCH -p cmhn-s18
#SBATCH -A cmhn-s18
#SBATCH -t 2:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH -n 2
#SBATCH --job-name fcma_voxel_select_cv
#SBATCH --output fcma_voxel_select_cv-%j.out

# Set up the environment
module load Langs/Python/3.5-anaconda
module load Pypkgs/brainiak/0.7.1-anaconda
module load Pypkgs/NILEARN/0.4.0-anaconda
module load MPI/OpenMPI

# How many threads can you make
export OMP_NUM_THREADS=32

# set the current dir
currentdir=`pwd`

# Prepare inputs to voxel selection function
data_dir=$1  # What is the directory containing data?
suffix=$2  # What is the extension of the data you're loading
mask_file=$3  # What is the path to the whole brain mask
epoch_file=$4  # What is the path to the epoch file
left_out_subj=$5  # Which participant (as an integer) are you leaving out for this cv?
output_dir=$6 # Where do you want to save the data

# Run the script
srun -n $SLURM_NTASKS --mpi=pmi2 python ./fcma_voxel_selection_cv.py $data_dir $suffix $mask_file $epoch_file $left_out_subj $output_dir
