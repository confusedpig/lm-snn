#!/bin/bash
#
#SBATCH --partition=longq
#SBATCH --time=02-00:00:00
#SBATCH --mem=30000
#SBATCH --account=rkozma

connectivity=${1:-none}
conv_size=${2:-28}
conv_stride=${3:-0}
conv_features=${4:-9}
lattice_structure=${5:-4}
weight_sharing=${6:-no_weight_sharing}
top_percent=${7:-10}
num_examples=${8:-1000}
reduced_dataset=${9:-True}
num_classes=${10:-9}
examples_per_class=${11:-100}

cd ../train/

python csnn_pc_mnist.py --mode=train --connectivity=$connectivity --weight_dependence=no_weight_dependence --post_pre=postpre --conv_size=$conv_size \
	--conv_stride=$conv_stride --conv_features=$conv_features --weight_sharing=$weight_sharing --lattice_structure=$lattice_structure --top_percent=$top_percent \
	--num_examples=$num_examples --reduced_dataset=$reduced_dataset --num_classes=$num_classes --examples_per_class=$examples_per_class
python csnn_pc_mnist.py --mode=test --connectivity=$connectivity --weight_dependence=no_weight_dependence --post_pre=postpre --conv_size=$conv_size \
	--conv_stride=$conv_stride --conv_features=$conv_features --weight_sharing=$weight_sharing --lattice_structure=$lattice_structure --top_percent=$top_percent
	--num_examples=$num_examples --reduced_dataset=$reduced_dataset --num_classes=$num_classes --examples_per_class=$examples_per_class

exit
