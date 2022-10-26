function sanity_check_imshow(input_filepath, output_filepath)
warning('off','MATLAB:MKDIR:DirectoryExists');

%%=========================================================================
input_filepath    = convertStringsToChars(input_filepath);
output_filepath   = convertStringsToChars(output_filepath);

%%=========================================================================
sanity_out = join(output_filepath, 'sanity_out');
mkdir(sanity_out);

%%=========================================================================
dir_list = dir(output_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    mip_file    = dir_list(dirIdx).name;
    file_path   = fullfile(output_filepath, mip_file);
    if (isfile(file_path))
        if (endsWith(mip_file, '.tif'))
            inp_file = fullfile(input_filepath, mip_file);
            out_file = fullfile(output_filepath, mip_file);
            fig = figure();
            subplot(1,2,1);
            imshow(inp_file)
            title("Input");
            subplot(1,2,2);
            imshow(out_file);
            title("Output");

            fig.WindowState = 'maximized';
            saveas(fig, [sanity_out '\' mip_file '.bmp'])
            clear fig;
            close all;
        end
    end
end
end