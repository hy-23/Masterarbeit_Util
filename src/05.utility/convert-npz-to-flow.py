import argparse
import os
import numpy as np
import neurite as ne

"""
# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--file-path', type=str, required=True, help='file path for warp npz files')
parser.add_argument('--name', type=str, required=True, help='file name of the warp npz files')
parser.add_argument('--scale', type=int, required=True, help='scale down factor to visualize neurite flow')
parser.add_argument('--slice-num', type=int, required=True, help='slice number whose flow needs to be visualized')
args = parser.parse_args()
"""

file_path   = 'I:\\03.masterarbeit_out\model_dc_safe_reg_01\out_dc_safe_reg_01'
name        = 'warped_np_GL_53A06_AE_01_081209A_scaled.npz'
scale       = 4
slice_num   = 20

src = os.path.join(file_path, name)
print(src)
npz = np.load(src)
a = npz['vol']
b = a[:,:,slice_num,:2]
c = b[1::scale, 1::scale, :] / scale
ne.plot.flow([c], width=5)