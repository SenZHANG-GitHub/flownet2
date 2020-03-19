module load python/3.6.5

source /project/RDS-FEI-szha2609-RW/venv/vinet/bin/activate

module load cuda/10.0.130
module load opencv/3.4.0
module load openmpi-gcc/3.1.3-cuda10
module load gcc/7.4.0
module load opencv/3.4.0
module load mpc/1.1.0
module load mpfr/3.1.4
module load gmp/6.1.0
module load ffmpeg/4.1

export PKG_CONFIG_PATH=/project/RDS-FEI-szha2609-RW/usr/lib64/pkgconfig:$PKG_CONFIG_PATH
export LD_LIBRARY_PATH=/project/RDS-FEI-szha2609-RW/usr/lib64:$LD_LIBRARY_PATH
export PYTHONPATH=/home/szha2609/src/odometry/flownet2-pytorch/networks/correlation_package:$PYTHONPATH
export PYTHONPATH=/home/szha2609/src/odometry/flownet2-pytorch/networks/resample2d_package:$PYTHONPATH
export PYTHONPATH=/home/szha2609/src/odometry/flownet2-pytorch/networks/channelnorm_package:$PYTHONPATH

cd "/project/RDS-FEI-szha2609-RW/src/odometry/flownet2-pytorch/"

# export folder=test
export folder=training
export type=final
export subtype_list="alley_1 alley_2 ambush_2 ambush_4 ambush_5 ambush_6 ambush_7 bamboo_1 bamboo_2 bandage_1 bandage_2 cave_2 cave_4 market_2 market_5 market_6 mountain_1 shaman_2 shaman_3 sleeping_1 sleeping_2 temple_2 temple_3"

export flow_model=FlowNet2
export ckp_name=FlowNet2_checkpoint.pth.tar
for subtype in $subtype_list
do 
    python -u main.py --inference --model $flow_model --save_flow --save results/"$folder"_$type/$flow_model/$subtype --inference_dataset ImagesFromFolder --inference_dataset_root data/Sintel/$folder/$type/$subtype --resume ckp/$ckp_name --inference_visualize
    rm results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/*
    rmdir results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/
done

export flow_model=FlowNet2S
export ckp_name=FlowNet2-S_checkpoint.pth.tar
for subtype in $subtype_list
do 
    python -u main.py --inference --model $flow_model --save_flow --save results/"$folder"_$type/$flow_model/$subtype --inference_dataset ImagesFromFolder --inference_dataset_root data/Sintel/$folder/$type/$subtype --resume ckp/$ckp_name --inference_visualize
    rm results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/*
    rmdir results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/
done

export flow_model=FlowNet2C
export ckp_name=FlowNet2-C_checkpoint.pth.tar
for subtype in $subtype_list
do 
    python -u main.py --inference --model $flow_model --save_flow --save results/"$folder"_$type/$flow_model/$subtype --inference_dataset ImagesFromFolder --inference_dataset_root data/Sintel/$folder/$type/$subtype --resume ckp/$ckp_name --inference_visualize
    rm results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/*
    rmdir results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/
done
