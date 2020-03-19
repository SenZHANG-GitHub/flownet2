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
export folder=test
export type=clean
export subtype_list="ambush_1 ambush_3 bamboo_3 cave_3 market_1 market_4 mountain_2 PERTURBED_market_3 PERTURBED_shaman_1 temple_1 tiger wall"

export flow_model=FlowNet2
export ckp_name=FlowNet2_checkpoint.pth.tar
for subtype in $subtype_list
do 
    python -u main.py --inference --model $flow_model --save_flow --save results/"$folder"_$type/$flow_model/$subtype --inference_dataset ImagesFromFolder --inference_dataset_root data/Sintel/$folder/$type/$subtype --resume ckp/$ckp_name
    python -m flowiz results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/*.flo --outdir results/"$folder"_$type/$flow_model/$subtype/inference
    rm results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/*
    rmdir results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/
done

export flow_model=FlowNet2S
export ckp_name=FlowNet2-S_checkpoint.pth.tar
for subtype in $subtype_list
do 
    python -u main.py --inference --model $flow_model --save_flow --save results/"$folder"_$type/$flow_model/$subtype --inference_dataset ImagesFromFolder --inference_dataset_root data/Sintel/$folder/$type/$subtype --resume ckp/$ckp_name
    python -m flowiz results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/*.flo --outdir results/"$folder"_$type/$flow_model/$subtype/inference
    rm results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/*
    rmdir results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/
done

export flow_model=FlowNet2C
export ckp_name=FlowNet2-C_checkpoint.pth.tar
for subtype in $subtype_list
do 
    python -u main.py --inference --model $flow_model --save_flow --save results/"$folder"_$type/$flow_model/$subtype --inference_dataset ImagesFromFolder --inference_dataset_root data/Sintel/$folder/$type/$subtype --resume ckp/$ckp_name
    python -m flowiz results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/*.flo --outdir results/"$folder"_$type/$flow_model/$subtype/inference
    rm results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/*
    rmdir results/"$folder"_$type/$flow_model/$subtype/inference/run.epoch-0-flow-field/
done
