function C = quantAssessment(tif_filepath)
warning('off','all');
pp_out = fullfile(tif_filepath, 'pp');
mkdir(pp_out);

rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
c3d = ['"' rootpath '\resources\exe\c3d.exe" '];
Template = 'D:\Harsha\important_npFixed\AtlasImgMedian.tif';
MaskPFN = 'D:\Harsha\important_npFixed\CNS_Mask.tif';
MaskPFN_VI = 'D:\Harsha\important_npFixed\vi_mask_r5.tif';
MaskPFN_TI = 'D:\Harsha\important_npFixed\ti_mask_r7.tif';

tif_filepath = convertStringsToChars(tif_filepath);
dir_list = dir(tif_filepath);
len_dir  = length(dir_list);

C = {"dummy" 0 0 0};
% first two entries are "." and ".." so let's ignore it.
for dirIdx = 3:len_dir
    file_or_folder_name = dir_list(dirIdx).name;
    file_or_folder_path = fullfile(tif_filepath, file_or_folder_name);
    if (isfile(file_or_folder_path))
        if (endsWith(file_or_folder_name, '.tif'))
            [~, scanID, ~] = fileparts(file_or_folder_name);
            in_file = file_or_folder_path;
            pp_file = fullfile(pp_out, file_or_folder_name);

            [status,cmdout] = system([  c3d '"' in_file '"  -info-full ']);
            Ctmp=textscan(cmdout,'%s','Delimiter',{'  Mean Intensity     : '});

            lowclip=num2str(ceil(cell2mat(textscan(Ctmp{1,1}{7,1},'%f'))));
            [status,cmdout] = system([  c3d '"' in_file '"  -clip ' lowclip ' 255  -replace ' lowclip ' 0  -type uchar -compress -o ' '"' pp_file '"' ]);

            [status,cmdout] = system([c3d '"' Template '"' ' ' '"' pp_file '"' ' ' '"' MaskPFN '"' ' -popas fmask -mmi']);
            res=textscan(cmdout,'%s','Delimiter',{'='});
            entire_scan = str2double(res{1,1}{2,1}) * -100;
            entire_scan = roundn(entire_scan, 0);

            [status,cmdout] = system([c3d '"' Template '"' ' ' '"' pp_file '"' ' ' '"' MaskPFN_VI '"' ' -popas fmask -mmi']);
            res=textscan(cmdout,'%s','Delimiter',{'='});
            vi_scan = str2double(res{1,1}{2,1}) * -100;
            vi_scan = roundn(vi_scan, 0);

            [status,cmdout] = system([c3d '"' Template '"' ' ' '"' pp_file '"' ' ' '"' MaskPFN_TI '"' ' -popas fmask -mmi']);
            res=textscan(cmdout,'%s','Delimiter',{'='});
            ti_scan = str2double(res{1,1}{2,1}) * -100;
            ti_scan = roundn(ti_scan, 0);

            c = {scanID entire_scan vi_scan ti_scan}
            C = [C; c];
        end
    end
end
T = cell2table(C, "VariableNames",["Scan" "Entire Scan" "VI" "TI"]);
writetable(T, [tif_filepath '\Quality.csv']);

end