function main_fix(bg_corrected_tif_filepath)
warning('off','MATLAB:MKDIR:DirectoryExists');

bg_corrected_tif_filepath = convertStringsToChars(bg_corrected_tif_filepath);
np_out = join(bg_corrected_tif_filepath, 'np-fixed');
mkdir(np_out);

dir_list = dir(bg_corrected_tif_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = join(bg_corrected_tif_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.tif'))
            fix_tif_properties(file_or_folder_path, np_out);
        end
    end
end
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end