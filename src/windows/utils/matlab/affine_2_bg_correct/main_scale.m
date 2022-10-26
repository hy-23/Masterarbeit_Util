%%
%% Author: Harsha Yogeshappa
%%

function outDir = main_scale(affine_aligned_tif_filepath, findNPChannel)
warning('off','MATLAB:MKDIR:DirectoryExists');
warning('off','all');

% data
width           = 256;
height          = 512;
slices          = 64;
%pixelwidth      = 0.4566360;
%pixelheight     = 0.4566360;
%voxeldepth      = 2.0000000;

outDir = 'scaled-np-channel';
affine_aligned_tif_filepath = convertStringsToChars(affine_aligned_tif_filepath);
scaled_np_out = join(affine_aligned_tif_filepath, outDir);
mkdir(scaled_np_out);

dir_list = dir(affine_aligned_tif_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = join(affine_aligned_tif_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.tif'))
            filename = file_or_folder_path;
            scale_lsm(filename, width, height, slices, ...
                      scaled_np_out, findNPChannel);
        end
    end
end
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end
