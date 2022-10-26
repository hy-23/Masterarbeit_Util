function generate_train_list(filepath, writefile, mode, platform)
if(platform == "posix")
    s = strrep(filepath, '\', '/');
    r = strrep(s, 'I:', '/work/scratch/yogeshappa');
else
    r = filepath;
end

dir_list = dir(filepath);
len_dir  = length(dir_list);

[writepath, writename, ext] = fileparts(writefile);
fileID = fopen([sepStr([writepath '\']) writename ext], mode);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    fname = dir_list(dirIdx).name;
    file_or_folder = join(filepath, fname);
    if(endsWith(file_or_folder, '.npz'))
        filename = [r '/' fname];
        fprintf(fileID,'%s\n',filename);
    else
            % any other file
    end
end
fclose(fileID);
end

function strRes = join(str1, str2)
strRes = [str1 '\' str2];
end