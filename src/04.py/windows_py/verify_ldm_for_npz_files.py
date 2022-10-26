from os import listdir
from os.path import isfile, join
mypath=r'I:\00.masterarbeit_dataset\04.LRV-ALL_Dataset-Affine_Registered\For_VXM\Janelia_Dataset\scaled-np-channel\background-corrected\fixed-properties\curated-template-like\TIFF_Affine_Registered_Again\npz'
filelist=[f for f in listdir(mypath) if isfile(join(mypath, f))]
npz_filelist=[f for f in filelist if f.endswith('.npz')]
pts_filelist=[f for f in filelist if f.endswith('.points')]
for i in range(len(npz_filelist)):
   npz_file=npz_filelist[i]
   pts_file=npz_file[:-3]+'points'
   if not pts_file in pts_filelist:
       print("{} does not have a landmark".format(npz_file))
