function main(affine_aligned_tif_filepath, findNPChannel)

% Step1: scaled the affine_aligned tif files.
outDir = main_scale(affine_aligned_tif_filepath, findNPChannel);

% Step2: remove background from the scaled tif files.
fprintf("\n");
fprintf("Perform background correction\n");
scaled_tif_filepath = [affine_aligned_tif_filepath '\' outDir];
outDir = main_bc(scaled_tif_filepath);

% Step3: fix the tif properties.
fprintf("\n");
fprintf("Fix tif properties\n");
bg_corrected_tif_filepath = [scaled_tif_filepath '\' outDir];
main_fix(bg_corrected_tif_filepath);

% plot mip files.
traverse_and_find_tif(scaled_tif_filepath);
end