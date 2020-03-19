module load python/3.6.5

source /project/RDS-FEI-szha2609-RW/venv/vinet/bin/activate

module load cuda/10.0.130
module load opencv/3.4.0
module load openmpi-gcc/3.1.3-cuda10
module load gcc/7.4.0
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
export subseq_list="00 01 02 04 05 06 07 08 09 10"

export flow_model=FlowNet2
export ckp_name=FlowNet2_checkpoint.pth.tar
for subseq in $subseq_list
do
    export load_folder=/project/RDS-FEI-szha2609-RW/src/odometry/vinet/data/kitti/odometry/dataset/sequences/"$subseq"/image_2
    export result_folder=results/kitti_odo/$flow_model/"$subseq"/image_2

    python -u main.py --inference --model $flow_model --save_flow --save $result_folder --inference_dataset ImagesFromFolder --inference_dataset_root $load_folder --resume ckp/$ckp_name --inference_visualize
    rm $result_folder/inference/run.epoch-0-flow-field/*
    rmdir $result_folder/inference/run.epoch-0-flow-field/
done

export flow_model=FlowNet2S
export ckp_name=FlowNet2-S_checkpoint.pth.tar
for subseq in $subseq_list
do
    export load_folder=/project/RDS-FEI-szha2609-RW/src/odometry/vinet/data/kitti/odometry/dataset/sequences/"$subseq"/image_2
    export result_folder=results/kitti_odo/$flow_model/"$subseq"/image_2

    python -u main.py --inference --model $flow_model --save_flow --save $result_folder --inference_dataset ImagesFromFolder --inference_dataset_root $load_folder --resume ckp/$ckp_name --inference_visualize
    rm $result_folder/inference/run.epoch-0-flow-field/*
    rmdir $result_folder/inference/run.epoch-0-flow-field/
done

export flow_model=FlowNet2C
export ckp_name=FlowNet2-C_checkpoint.pth.tar
for subseq in $subseq_list
do
    export load_folder=/project/RDS-FEI-szha2609-RW/src/odometry/vinet/data/kitti/odometry/dataset/sequences/"$subseq"/image_2
    export result_folder=results/kitti_odo/$flow_model/"$subseq"/image_2

    python -u main.py --inference --model $flow_model --save_flow --save $result_folder --inference_dataset ImagesFromFolder --inference_dataset_root $load_folder --resume ckp/$ckp_name --inference_visualize
    rm $result_folder/inference/run.epoch-0-flow-field/*
    rmdir $result_folder/inference/run.epoch-0-flow-field/
done



