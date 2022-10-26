# Python program to read
# json file

import json

class MyStruct():
    def __init__(self, data):
        self.img_list           = data['img_list']
        self.atlas              = data['atlas']
        self.model_dir          = data['model_dir']
        self.epochs             = data['epochs']
        self.enc                = data['enc']
        self.dec                = data['dec']
        self.steps_per_epoch    = data['steps_per_epoch']
        self.gpu                = data['gpu']
        self.batch_size         = data['batch_size']
        self.initial_epoch      = data['initial_epoch']
        self.lr                 = data['lr']
        self.int_steps          = data['int_steps']
        self.int_downsize       = data['int_downsize']
        self.kl_lambda          = data['kl_lambda']
        self.image_sigma        = data['image_sigma']
        self.image_loss         = data['image_loss']
        self.multichannel       = data['multichannel']
        self.use_probs          = data['use_probs']
        self.bidir              = data['bidir']
        self.lambda_weight      = data['lambda_weight']
        self.img_prefix         = data['img_prefix']
        self.img_suffix         = data['img_suffix']
        self.load_weights       = data['load_weights']
        self.use_steps_per_epoch= data['use_steps_per_epoch']

# Opening JSON file
f = open('Y:\\repo\Masterarbeit\src\config.json')

# returns JSON object as
# a dictionary
data = json.load(f)

args = MyStruct(data)
print(args.img_list)
print(args.atlas)
print(args.model_dir)
print(args.epochs)
print(args.enc)
print(args.dec)
print(args.steps_per_epoch)
print(args.gpu)
print(args.batch_size)
print(args.initial_epoch)
print(args.lr)
print(args.int_steps)
print(args.int_downsize)
print(args.kl_lambda)
print(args.image_sigma)
print(args.image_loss)
print(args.multichannel)
print(args.use_probs)
print(args.bidir)
print(args.lambda_weight)
print(args.img_prefix)
print(args.img_suffix)
print(args.load_weights)
print(args.use_steps_per_epoch)


# Iterating through the json
# list
#for i in data:
#	print("{} : {}".format(i, data[i]))

# Closing file
f.close()
