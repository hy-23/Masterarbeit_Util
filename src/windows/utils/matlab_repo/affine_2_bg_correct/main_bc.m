function outDir = main_bc(scaled_tif_filepath)
warning('off','MATLAB:MKDIR:DirectoryExists');
% rootpath should be a folder.

dir_list = dir(scaled_tif_filepath);
len_dir  = length(dir_list);

outDir = 'bg_corrected';

bc_out = join(scaled_tif_filepath, outDir);
mkdir(bc_out);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder = dir_list(dirIdx).name;
    file_or_folder = join(scaled_tif_filepath, file_or_folder);
    if(endsWith(file_or_folder, '.tif'))
        % is a tif file, so call max_projection
        remove_background(file_or_folder, outDir);
    else
        % any other file
    end
end
end

function strRes = join(str1, str2)
strRes = [str1 '\' str2];
end