# Import the json library
import os
import json
import argparse

# parse the commandline
parser = argparse.ArgumentParser()
parser.add_argument('--platform', required=True, help='configuration specific to platforms')
spec = parser.parse_args()

# Get the Json data from the question into a variable...
if spec.platform == 'nt':
    data_file_path = """{
    "img_list": "I:\\\\00.masterarbeit_dataset\\\\vscode_default.txt",
    "atlas_file": "I:\\\\00.masterarbeit_dataset\\\\00.atlas\\\\np-scaled-channel\\\\npz\\\\np_atlas_scaled.npz",
    "model_dir": "I:\\\\03.masterarbeit_out\\\\vscode_landmark_distance","""
elif spec.platform == 'posix':
    data_file_path = """{
    "img_list": "/work/scratch/yogeshappa/00.masterarbeit_dataset/06.condor/data_list/02.curated.txt",
    "atlas_file": "/work/scratch/yogeshappa/00.masterarbeit_dataset/00.atlas/np-scaled-channel/npz/np_atlas_scaled.npz",
    "model_dir": "/work/scratch/yogeshappa/03.masterarbeit_out/janelia_landmark_curated_condor","""

data_parameters = """
    "seg_suffix": "_points.npz",
    "seg_prefix": "",
    "epochs": 100,
    "steps_per_epoch": 290,
    "gpu": 0,
    "initial_epoch": 0,
    "int_steps": 0,
    "int_downsize": 2,
    "image_loss": "mse",
    "lr": 1e-3,
    "enc": [16, 32, 32, 32, 32],
    "dec": [32, 32, 32, 32, 32, 32, 16, 16],
    "max_pool": [[2,2,1], [2,2,1], [2,2,2], [2,2,2], [2,2,2]],
    "grad_loss_weight": 0.03,
    "load_weights": "",
    "n_gradients": 29,
    "_comment": ""
}
"""


# Writing to sample.json
with open("Y:\\repo_condor\Masterarbeit\src\config_ldm.json", "w") as outfile:
   outfile.write(data_file_path)
   outfile.write(data_parameters)