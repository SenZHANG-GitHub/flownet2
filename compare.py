import matplotlib.pyplot as plt
import matplotlib.image as img
import os
from shutil import rmtree
from tqdm import tqdm
import pdb
import argparse

def compare_flow_sintel(task, out_dir):
    """
    (1) task:
    -> for Sintel: training_clean, training_final
    """
    use_gt = True if 'training' in task else False
    model_list = ['FlowNet2', 'FlowNet2C', 'FlowNet2S']
    num_model = len(model_list)
    if use_gt: num_model += 1 # include ground-truth for display
    subtype_list = os.listdir('Sintel/results/{}/FlowNet2'.format(task))
    for subtype in subtype_list:
        print('processing {}...'.format(subtype))
        os.mkdir('{}/{}'.format(out_dir, subtype))
        # get image filenames
        img_list = [x for x in os.listdir('Sintel/results/{}/FlowNet2/{}/inference/run.epoch-0-flow-vis'.format(task, subtype)) if x[-4:] == '.png']
        for img_file in tqdm(img_list):
            if use_gt:
                img_subname = int(img_file.split('-')[0]) + 1
                img_path = 'Sintel/results/flow_viz/{}/frame_{:04d}.png'.format(subtype, img_subname)
                tmp_img = img.imread(img_path)
                plt.subplot(num_model, 1, 1)
                plt.imshow(tmp_img)
                plt.title('Ground Truth', y=-0.23) # plt.text(15, -0.01, "tmp")
                plt.axis('off')
            for i_model, flow_model in enumerate(model_list):
                img_path = 'Sintel/results/{}/{}/{}/inference/run.epoch-0-flow-vis/{}'.format(task, flow_model, subtype, img_file)
                tmp_img = img.imread(img_path)
                sub_ind = i_model + 1 
                if use_gt: sub_ind += 1 
                plt.subplot(num_model, 1, sub_ind)
                plt.imshow(tmp_img)
                plt.title('{}'.format(flow_model), y=-0.23) 
                plt.axis('off')
            plt.savefig('{}/{}/{}'.format(out_dir, subtype, img_file))


def compare_flow_kitti(dataset, out_dir):
    """
    (1) dataset:    kitti_odometry, kitti_2012, kitti_2015
    (2) out_dir: 'kitti_odometry/results/compare'
    """
    use_gt = False if dataset == 'kitti_odometry' else True
    model_list = ['FlowNet2', 'FlowNet2C', 'FlowNet2S']
    num_model = len(model_list)
    if use_gt: num_model += 1 # include ground-truth for display
    subtype_list = os.listdir('{}/results/FlowNet2C'.format(dataset))
    for subtype in subtype_list:
        print('processing {}...'.format(subtype))
        os.mkdir('{}/{}'.format(out_dir, subtype))
        # get image filenames
        img_list = [x for x in os.listdir('{}/results/FlowNet2/{}/image_2/inference/run.epoch-0-flow-vis'.format(dataset, subtype)) if x[-4:] == '.png']
        for img_file in tqdm(img_list):
            if use_gt:
                raise NotImplementedError('to implement')
                # img_subname = int(img_file.split('-')[0]) + 1
                # img_path = 'Sintel/results/flow_viz/{}/frame_{:04d}.png'.format(subtype, img_subname)
                tmp_img = img.imread(img_path)
                plt.subplot(num_model, 1, 1)
                plt.imshow(tmp_img)
                plt.title('Ground Truth', y=-0.23) # plt.text(15, -0.01, "tmp")
                plt.axis('off')
            for i_model, flow_model in enumerate(model_list):
                img_path = '{}/results/{}/{}/image_2/inference/run.epoch-0-flow-vis/{}'.format(dataset, flow_model, subtype, img_file)
                tmp_img = img.imread(img_path)
                sub_ind = i_model + 1 
                if use_gt: sub_ind += 1 
                plt.subplot(num_model, 1, sub_ind)
                plt.imshow(tmp_img)
                plt.title('{}'.format(flow_model), y=-0.23) 
                plt.axis('off')
            plt.savefig('{}/{}/{}'.format(out_dir, subtype, img_file))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument('--dataset', type=str, default='Sintel') # kitti_odometry, kitti_2012, kitti_2015
    parser.add_argument('--task', type=str, default='training_clean')

    args = parser.parse_args()

    if args.dataset == 'Sintel':
        out_dir = 'Sintel/results/{}/compare'.format(args.task)
        if os.path.isdir(out_dir): rmtree(out_dir)
        os.mkdir(out_dir)
        compare_flow_sintel(
            task    = args.task,
            out_dir = out_dir
        )
    elif args.dataset == 'kitti_odometry':
        out_dir = 'kitti_odometry/results/compare'
        if os.path.isdir(out_dir): rmtree(out_dir)
        os.mkdir(out_dir)
        compare_flow_kitti(
            dataset = args.dataset,
            out_dir = out_dir
        )
    else:
        raise ValueError('--dataset {} is not supported'.format(args.dataset))