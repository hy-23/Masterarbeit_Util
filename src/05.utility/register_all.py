import os
import sys
import time
import argparse
import tensorflow as tf
import numpy as np
from scipy.io import savemat

# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--repo', required=True, help='configuration specific to repository')
spec = parser.parse_args()

if os.name == 'nt': # windows 
    if spec.repo == 'repo':
        sys.path.append('Y:\\repo\Masterarbeit\\voxelmorph')
    elif spec.repo == 'condor':
        sys.path.append('Y:\\repo_condor\Masterarbeit\\voxelmorph')
elif os.name == 'posix': # nic system
    if spec.repo == 'repo':
        sys.path.append('/home/students/yogeshappa/repo/Masterarbeit/voxelmorph')
    elif spec.repo == 'condor':
        sys.path.append('/home/students/yogeshappa/repo_condor/Masterarbeit/voxelmorph')

import voxelmorph_custom as vxm

def vxm_register(file_list, gpu, fixed, multichannel, savewarp, model, out_path):
    predict_files = vxm.py.utils.read_file_list(file_list)
    assert len(predict_files) > 0, 'Could not find any data.'

    add_feat_axis = not multichannel
    # load fixed image.
    fixed, fixed_affine = vxm.py.utils.load_volfile(
        fixed, add_batch_axis=True, add_feat_axis=add_feat_axis, ret_affine=True)
    print('Fixed volfile is loaded.')
    print()

    for i in range(len(predict_files)):
        # tensorflow device handling
        device, nb_devices = vxm.tf.utils.setup_device(gpu)
    
        # load moving images
        moving = vxm.py.utils.load_volfile(predict_files[i], add_batch_axis=True, add_feat_axis=add_feat_axis)

        inshape = moving.shape[1:-1]
        nb_feats = moving.shape[-1]
    
        t0 = time.time()
        with tf.device(device):
            # load model and predict
            config = dict(inshape=inshape, input_model=None)
            warp = vxm.networks.VxmDenseSemiSupervisedLandmarks.load(model, **config).register(moving, fixed)
            moved = vxm.networks.Transform(inshape, nb_feats=nb_feats).predict([moving, warp])
        t1 = time.time()
    
        head_tail = os.path.split(predict_files[i])
    
        # save warp
        if savewarp:
            warp_file = os.path.join(out_path, 'warped_'+head_tail[-1])
            vxm.py.utils.save_volfile(warp.squeeze(), warp_file, fixed_affine)
    
        moved_file = os.path.join(out_path, 'moved_'+head_tail[-1])
        print("Predicted \t\t{}".format(head_tail[-1]))
        print('Time for prediction:\t{}'.format(t1-t0))

        # save moved image
        vxm.py.utils.save_volfile(moved.squeeze(), moved_file, fixed_affine)
        print()

# path where all the npz files are there.
def convert_npztomat(src_file_path):
    dst_file_path = os.path.join(src_file_path, 'mat')
    os.mkdir(dst_file_path)

    # list everything in the path; both directories and files.
    dirlist = os.listdir(src_file_path)

    # list of npz files in the src_file_path
    npz_file = [file for file in dirlist if (os.path.isfile(os.path.join(src_file_path, file)) and file.endswith('.npz'))]

    for npz_idx in range(len(npz_file)):
        src = os.path.join(src_file_path, npz_file[npz_idx])
        print("Generating mat file for {} ...".format(src))
        dst_file = npz_file[npz_idx].replace('.npz', '.mat')
        dst = os.path.join(dst_file_path, dst_file)
        npz = np.load(src)
        a = npz['vol']

        name = os.path.split(src)[-1]
        var_name = os.path.splitext(name)[-2] # split name and extension.
        mdic = {var_name : a}

        savemat(dst, mdic)

multichannel    = False
savewarp        = False
gpu             = 0
if os.name == 'nt': # windows system
    file_list   = 'I:\\00.masterarbeit_dataset\\test_nt.txt'
    fixed       = 'I:\\00.masterarbeit_dataset\\00.atlas\\np-scaled-channel\\npz\\np_atlas_scaled.npz'
    model       = 'I:\\03.masterarbeit_out\\xxxxvscodexxxx\\0040.h5'
    out_path    = 'I:\\03.masterarbeit_out\\xxxxvscodexxxx\\out'
    
elif os.name == 'posix': # nic system
    file_list   = '/work/scratch/yogeshappa/00.masterarbeit_dataset/test_posix.txt'
    fixed       = '/work/scratch/yogeshappa/00.masterarbeit_dataset/00.atlas/np-scaled-channel/npz/np_atlas_scaled.npz'
    model       = '/work/scratch/yogeshappa/03.masterarbeit_out/xxxxvscodexxxx/0040.h5'
    out_path    = '/work/scratch/yogeshappa/03.masterarbeit_out/xxxxvscodexxxx/out'

try:
    os.makedirs(out_path, exist_ok = True)
    print("Directory '%s' created successfully" %out_path)
except OSError as error:
    print("Directory '%s' can not be created" %out_path)

vxm_register(file_list, gpu, fixed, multichannel, savewarp, model, out_path)
convert_npztomat(out_path)