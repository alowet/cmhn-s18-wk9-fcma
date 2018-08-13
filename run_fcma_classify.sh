#!/bin/bash
#SBATCH -p cmhn-s18
#SBATCH -A cmhn-s18
#SBATCH -t 1:00:00
#SBATCH --mem-per-cpu=12G
#SBATCH -n 2
#SBATCH --job-name fcma_classify

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
mask_file=$3  #What is the path to the top N mask file (THIS IS NOT THE WHOLE BRAIN MASK)
epoch_file=$4  # What is the path to the epoch file
left_out_subj=$5  #Which participant (as an integer) are you using for testing? 
second_mask=$6  # Do you want to use a second mask to compare the data with? Necessary for extrinsic analyses. Otherwise ignore this input or set to None

# Run the script
srun -n $SLURM_NTASKS --mpi=pmi2 python ./fcma_classify.py $data_dir $suffix $mask_file $epoch_file $left_out_subj $second_mask
