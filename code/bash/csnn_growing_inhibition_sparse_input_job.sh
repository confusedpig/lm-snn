#!/bin/bash
#
#SBATCH --partition=longq
#SBATCH --time=02-00:00:00
#SBATCH --mem=30000
#SBATCH --account=rkozma
#SBATCH --output=/mnt/nfs/work1/rkozma/djsaunde/stdp-mnist/code/bash/job_reports/%j.out

conv_size=${1:-28}
conv_stride=${2:-0}
conv_features=${3:-100}
num_train=${4:-10000}
random_seed=${5:-42}
normalize_inputs=${6:-True}
proportion_grow=${7:-1.0}
noise_const=${8:-0.0}
input_sparsity=${9:-0.75}

cd ../train/

echo "csnn_growing_inhibition_sparse_input_job.sh"

python csnn_growing_inhibition_sparse_input.py --mode=train --num_train=$num_train --conv_size=$conv_size --conv_stride=$conv_stride --noise_const=$noise_const \
	--conv_features=$conv_features --random_seed=$random_seed --normalize_inputs=$normalize_inputs --proportion_grow=$proportion_grow --input_sparsity=$input_sparsity

python csnn_growing_inhibition_sparse_input.py --mode=test --num_test=10000 --conv_size=$conv_size --conv_stride=$conv_stride --proportion_grow=$proportion_grow \
	--conv_features=$conv_features --num_train=$num_train --random_seed=$random_seed --normalize_inputs=$normalize_inputs --noise_const=$noise_const --input_sparsity=$input_sparsity

exit
