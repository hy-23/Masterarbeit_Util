################################################# Fixed #################################################
file_list       = 'I:\\00.masterarbeit_dataset\\test.txt'
gpu             = 0
fixed           = 'I:\\00.masterarbeit_dataset\\00.atlas\\np-scaled-channel\\npz\\np_atlas_scaled.npz'
multichannel    = False
savewarp        = True
############################################## Variable ##################################################

tensor_out      = 'I:\\03.masterarbeit_out'
############################################## Derived ###################################################

model           = tensor_out + '\\vscode_landmark_distance\\0100.h5'
out_path        = tensor_out + '\\vscode_landmark_distance\out'
##########################################################################################################

import os
import argparse

# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--repo', required=True, help='configuration specific to platforms')
spec = parser.parse_args()


if os.name == 'nt': # windows system
    if spec.repo == 'repo':
        sys.path.append('Y:\\repo\Masterarbeit\\voxelmorph')
    elif spec.repo == 'condor':
        sys.path.append('Y:\\repo_condor\Masterarbeit\\voxelmorph')
    
elif os.name == 'posix': # nic system
    if spec.repo == 'repo':
        sys.path.append('/home/students/yogeshappa/repo/Masterarbeit/voxelmorph')
    elif spec.repo == 'condor':
        sys.path.append('/home/students/yogeshappa/repo_condor/Masterarbeit/voxelmorph')

from register_all import vxm_register
from npz_to_mat import convert_npztomat

try:
    os.makedirs(out_path, exist_ok = True)
    print("Directory '%s' created successfully" %out_path)
except OSError as error:
    print("Directory '%s' can not be created" %out_path)
vxm_register(file_list, gpu, fixed, multichannel, savewarp, model, out_path)
convert_npztomat(out_path)