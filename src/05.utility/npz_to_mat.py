import numpy as np
from scipy.io import savemat
import os

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

