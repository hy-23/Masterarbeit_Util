function t = analyze_results(bplot, bCompare, str_filepath, ...
                             vxm_rootpath, cmp_rootpath, ...
                             vxm_name, cmp_name)

%% Parameters:
% bplot = true/false: decision whether to plot imshowpair between the two
% results we are interested in.
% bCompare = true/false: if false, then the result will be compared against
% the larvalign registrered output.
% str_filepath = path where you wish to store imshowpair and the mmi score
% in an excel sheet.
% vxm_rootpath = path where properties fixed np files are stored.
% cmp_rootpath = path where properties fixed np files are stored.
% vxm_name = string name for printing on imshowpair.
% cmp_name = string name for printing on imshowpair.

%% example
%{
bCompare = false;
cmp_rootpath = '';
cmp_name = '';
bplot = false;
str_filepath = 'I:\03.masterarbeit_out\imshowpair';
vxm_rootpath = 'I:\03.masterarbeit_out\out\mat\tiff\np-channel';
vxm_name = 'Voxelmorph_Diffeo_560';

t = analyze_results(bplot, bCompare, str_filepath, vxm_rootpath, cmp_rootpath, vxm_name, cmp_name);
%}

if(bCompare == true)
    t = visuallyEvaluate(str_filepath, vxm_rootpath, cmp_rootpath, ...
        vxm_name, cmp_name, bplot);
else
    % constant
    lrv_rootpath = 'I:\00.masterarbeit_dataset\03.LRV-Dataset_Good_Bad_Random-NonLinearly_Registered\tiff\np-channel';
    t = visuallyEvaluate(str_filepath, vxm_rootpath, lrv_rootpath, ...
        vxm_name, 'Larvalign', bplot);
end
end


%{
bPlot = true;
bCompare = false;
str_filepath = 'I:\03.masterarbeit_out\noDiffeo_vs_larvalign';
cmp_rootpath = '';
cmp_name = '';
vxm_rootpath = 'I:\03.masterarbeit_out\change_005-without-diffeomorphisim\out\mat\tiff\np-channel';
vxm_name = 'No_Diffeo';
t = analyze_results(bPlot, bCompare, str_filepath, vxm_rootpath, cmp_rootpath, vxm_name, cmp_name);

vxm_rootpath = 'I:\03.masterarbeit_out\change_006-with-diffeomorphism\out\mat\tiff\np-channel';
vxm_name = 'With_Diffeo';
str_filepath = 'I:\03.masterarbeit_out\withDiffeo_vs_larvalign';
t = analyze_results(bPlot, bCompare, str_filepath, vxm_rootpath, cmp_rootpath, vxm_name, cmp_name);

bCompare = true;
cmp_rootpath = 'I:\03.masterarbeit_out\change_005-without-diffeomorphisim\out\mat\tiff\np-channel';
cmp_name = 'No_Diffeo';
str_filepath = 'I:\03.masterarbeit_out\withDiffeo_vs_noDiffeo';
t = analyze_results(bPlot, bCompare, str_filepath, vxm_rootpath, cmp_rootpath, vxm_name, cmp_name);

fprintf("Done\n");
%}