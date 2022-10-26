function sanity_check(original_filepath, bg_corrected_filepath)
warning('off','MATLAB:MKDIR:DirectoryExists');

%%=========================================================================
original_filepath       = convertStringsToChars(original_filepath);
bg_corrected_filepath   = convertStringsToChars(bg_corrected_filepath);

%%=========================================================================
sanity_out = join(bg_corrected_filepath, 'sanity_out');
mkdir(sanity_out);

%%=========================================================================
dir_list = dir(bg_corrected_filepath);
len_dir  = length(dir_list);

% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    mip_file    = dir_list(dirIdx).name;
    file_path   = join(bg_corrected_filepath, mip_file);
    if (isfile(file_path))
        if (endsWith(mip_file, '.tif'))
            org_file = [original_filepath '\' mip_file];
            bgc_file = [bg_corrected_filepath '\' mip_file];
            o = read_tiff_stack(org_file);
            b = read_tiff_stack(bgc_file);
            fig = figure();
            subplot(1,2,1);
            imagesc(o);
            title("Original");
            subplot(1,2,2);
            imagesc(b);
            title("BG Corrected");

            fig.WindowState = 'maximized';
            saveas(fig, [sanity_out '\' mip_file '.bmp'])
            clear fig;
            close all;
        end
    end
end
end

%%=========================================================================

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end