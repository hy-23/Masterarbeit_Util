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
    "img_list": "I:\\\\00.masterarbeit_dataset\\\\curated_vscode.txt",
    "val_list": "",
    "atlas": "I:\\\\00.masterarbeit_dataset\\\\00.atlas\\\\np-scaled-channel\\\\npz\\\\np_atlas_scaled.npz",
    "model_dir": "I:\\\\03.masterarbeit_out\\\\xxxxvscodexxxx","""
elif spec.platform == 'posix':
    data_file_path = """{
    "img_list": "/work/scratch/yogeshappa/00.masterarbeit_dataset/06.condor/curated.txt",
    "val_list": "",
    "atlas": "/work/scratch/yogeshappa/00.masterarbeit_dataset/00.atlas/np-scaled-channel/npz/np_atlas_scaled.npz",
    "model_dir": "/work/scratch/yogeshappa/03.masterarbeit_out/xxxx_vanilla_condor_xxxxxx","""

data_parameters = """
    "epochs": 60,
    "steps_per_epoch": 290,
    "gpu": 0,
    "batch_size": 1,
    "initial_epoch": 0,
    "int_steps": 0,
    "int_downsize": 2,
    "kl_lambda": 10,
    "image_sigma": 1.0,
    "image_loss": "mse",
    "lr": 1e-3,
    "enc": [16, 32, 32, 32, 32, 32],
    "dec": [32, 32, 32, 32, 32, 32, 32, 16, 16],
    "max_pool": [[2,2,1], [2,2,1], [2,2,2], [2,2,2], [2,2,2], [2,2,2]],
    "multichannel": false,
    "use_probs": false,
    "bidir": false,
    "lambda_weight": 0.5,
    "img_prefix": "",
    "img_suffix": "",
    "load_weights": "",
    "use_validation": false,
    "n_gradients": 10,
    "_comment": ""
}
"""


# Writing to sample.json
if spec.platform == 'nt':
    with open("Y:\\repo_vanilla\Masterarbeit_Util\src\\00.config_vanilla\config_vanilla.json", "w") as outfile:
        outfile.write(data_file_path)
        outfile.write(data_parameters)
elif spec.platform == 'posix':
    with open("/home/students/yogeshappa/repo_vanilla/Masterarbeit_Util/src/00.config_vanilla/config_vanilla.json", "w") as outfile:
        outfile.write(data_file_path)
        outfile.write(data_parameters)

# Convert that data into a python object... -> logic in read_json.py
"""
data = json.loads(data_from_api)
f = open('config.json')
d = json.load(f)
f.close()
print(d)
print(data)
"""