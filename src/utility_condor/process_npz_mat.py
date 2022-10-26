
import os

################################################# Fixed #################################################
if os.name == 'nt':
    file_list       = '/work/scratch/yogeshappa/00.masterarbeit_dataset/test_nt_2.txt'
else:
    file_list       = '/work/scratch/yogeshappa/00.masterarbeit_dataset/test_posix.txt'

gpu             = 0
fixed           = '/work/scratch/yogeshappa/00.masterarbeit_dataset/00.atlas/np-scaled-channel/npz/np_atlas_scaled.npz'
multichannel    = False
savewarp        = False

############################################## Derived ###################################################

model           = '/work/scratch/yogeshappa/03.masterarbeit_out/janelia_landmark_curated_condor_larger_size_final_layer/0100.h5'
out_path        = '/work/scratch/yogeshappa/03.masterarbeit_out/janelia_landmark_curated_condor_larger_size_final_layer/out'
##########################################################################################################

from register_all import vxm_register
from npz_to_mat import convert_npztomat

def windows_name(filename):
    print("filename: {}".format(filename))
    filename = filename.replace("/work/scratch/yogeshappa", "I:")
    filename = filename.replace("/", "\\")
    return filename

if os.name == 'nt':
    print("inside if")
    file_list   = windows_name(file_list)
    fixed       = windows_name(fixed)
    out_path    = windows_name(out_path)
    model       = windows_name(model)

try:
    os.makedirs(out_path, exist_ok = True)
    print("Directory '%s' created successfully" %out_path)
except OSError as error:
    print("Directory '%s' can not be created" %out_path)
vxm_register(file_list, gpu, fixed, multichannel, savewarp, model, out_path)
convert_npztomat(out_path)