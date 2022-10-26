import os
import sys

if os.name == 'nt': # windows system
    sys.path.append('Y:\\repo_condor\Masterarbeit\\voxelmorph')
elif os.name == 'posix': # nic system
    sys.path.append('/home/students/yogeshappa/repo_condor/Masterarbeit/voxelmorph')
    
import numpy as np
import voxelmorph_custom as vxm
import tensorflow as tf
import time

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