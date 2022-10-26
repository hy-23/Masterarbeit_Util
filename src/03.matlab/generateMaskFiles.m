function generateMaskFiles(tif_filepath)
warning('off','MATLAB:MKDIR:DirectoryExists');

tif_filepath = convertStringsToChars(tif_filepath);
mask_file = fullfile(tif_filepath, 'Mask');
mkdir(mask_file);

dir_list = dir(tif_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = fullfile(tif_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.tif'))
            [~, filename, ext] = fileparts(file_or_folder_path);
            printformask(file_or_folder_path, mask_file);
        end
    end
end
end