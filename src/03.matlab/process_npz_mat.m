function process_npz_mat(mat_filepath)
warning('off','all');

% process all mat files and generate tif files.
mat_to_tiff(mat_filepath);

% process the generated tif files and fix its properties.
tif_filepath = [mat_filepath '\tiff'];
main_fix(tif_filepath);

% from the processed tif files generate mip.
np_path = [tif_filepath '\np-fixed'];
traverse_and_find_tif(np_path)
end