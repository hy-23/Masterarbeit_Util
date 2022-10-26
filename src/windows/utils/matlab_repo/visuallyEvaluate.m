function t = visuallyEvaluate(str_filepath, vxm_rootpath, cmp_rootpath, ...
                          vxm_name, cmp_name, bplot)
warning('off','MATLAB:MKDIR:DirectoryExists');

%% initialization
brain = [];
v_mmi = [];
c_mmi = [];

%% constants
ats_rootpath = 'I:\00.masterarbeit_dataset\00.atlas\np-scaled-channel\np-scaled-channel-tiff';
sub_rootpath = 'I:\00.masterarbeit_dataset\04.LRV-ALL_Dataset-Affine_Registered\Dataset_Good_Bad_Random\tiff\scaled-np-channel\tiff';

%%
mkdir(str_filepath);    % storage file's filepath.

%% mip files
vxm_mip     = join(vxm_rootpath, 'mip'); %vxm results
cmp_mip     = join(cmp_rootpath, 'mip'); %cmp results
sub_mip     = join(sub_rootpath, 'mip'); %subject files
ats_mip     = join(ats_rootpath, 'mip'); %atlas files

%
ats_plot_file = [ats_mip '\' 'np_atlas_scaled.tif'];

sub_mip_list    = dir(sub_mip);
len_sub_mip     = length(sub_mip_list);

% first 2 indices will be "." and ".."
for subIdx = 3 : len_sub_mip
    sub_file = sub_mip_list(subIdx).name;       % e.g., sub_file = "harsha.tif"
    reg_file = convertStringsToChars(sub_file); % e.g., reg_file = 'harsha.tif'

    %% Assertion checks for files that will get plotted.
    % MIP are the final output: npz-mat-tif-scaled_tif-mip.
    % If MIP is present then all other files must also be present.

    sub_plot_file = [sub_mip '\' reg_file];

    vxm_plot_file = [vxm_mip '\' reg_file];
    cmp_plot_file = [cmp_mip '\' reg_file];

    assert( (isfile(vxm_plot_file) || isfile(cmp_plot_file)), ...
        ['Registration of moving file %s is not available either in ' ...
        'vxm or lrv'], sub_file);

    vxm_mmi_file = [vxm_rootpath '\' reg_file];
    cmp_mmi_file = [cmp_rootpath '\' reg_file];

    fprintf("Registration Error Measure for %s\n", reg_file);
    %% Perform RegistrationErrorMeasure.
    fprintf("%s\t", vxm_name);
    [v_tmp_mmi, v_tmp_brain] = RegistrationErrorMeasure(vxm_mmi_file);
    v_mmi = [v_mmi v_tmp_mmi];
    brain = [brain v_tmp_brain];

    fprintf("%s\t", cmp_name);
    [l_tmp_mmi, ~] = RegistrationErrorMeasure(cmp_mmi_file);
    c_mmi = [c_mmi l_tmp_mmi];

    if (bplot == true)
        fprintf("Plotting imshowpair()\n");
        %% Plot imshowpair
        plot_imshowpair(ats_plot_file, sub_plot_file, ...
                        vxm_plot_file, cmp_plot_file, ...
                        vxm_name, cmp_name, ...
                        v_tmp_mmi, l_tmp_mmi, str_filepath);
    end
    fprintf("\n");

end
mmi = [v_mmi; c_mmi];
t = writeToTable(mmi, brain, str_filepath);
end

function str3 = join(str1, str2)
str3 = [str1 '\' str2];
end

function plot_imshowpair(ats_plot_file, sub_plot_file, ...
                         vxm_plot_file, cmp_plot_file, ...
                         vxm_name, cmp_name, ...
                         v_mmi, c_mmi, str_filepath)

ats_image = imread(ats_plot_file);
sub_image = imread(sub_plot_file);
cmp_image = imread(cmp_plot_file);
vxm_image = imread(vxm_plot_file);

[~, name, ext] = fileparts(sub_plot_file);

fig = figure("Name", name);
subplot(2,4,1);
imshow(ats_image)
title("Atlas Image", "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,2);
imshow(sub_image);
title("Subject Image", "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,3);
imshow(vxm_image);
title([vxm_name ' Registered'], "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,4);
imshowpair(ats_image, vxm_image);
v_mmi_title = sprintf("MMI: %d", v_mmi);
title(v_mmi_title);
colorbar();
axis('on');

subplot(2,4,5);
imshow(ats_image)
title("Atlas Image", "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,6);
imshow(sub_image);
title("Subject Image", "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,7);
imshow(cmp_image);
title([cmp_name ' Registered'], "Interpreter", "none");
colorbar();
axis('on');

subplot(2,4,8);
imshowpair(ats_image, cmp_image);
c_mmi_title = sprintf("MMI: %d", c_mmi);
title(c_mmi_title);
colorbar();
axis('on');

fig.WindowState = 'maximized';
saveas(fig, [str_filepath '\' name ext])
clear fig;
close all;
end