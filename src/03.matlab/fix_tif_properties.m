function fix_tif_properties(filename, out_filepath)

[filepath, name, ext] = fileparts(filename);
scanID = [name ext];
fprintf("fix_tif_properties: %s\n", scanID);

tbd_filepath = 'D:\Harsha\tbd';

FijiExe = '"D:\fiji-win64\Fiji.app\ImageJ-win64.exe" ';

stmt0 = 'run("ImageJ2...", "scijavaio=true");';
stmt1 = ['open("' filepath '\' scanID '");'];
stmt2 = 'run("Properties...", "channels=1 slices=64 frames=1 unit=mm pixel_width=0.4566402 pixel_height=0.4566402 voxel_depth=2.0000");';
stmt3 = ['run("Save", "save=' out_filepath '\' name ext '");'];
stmt4 = 'close();';

fileID = fopen([sepStr([tbd_filepath '\']) name '_lsm2mhd.ijm'],'w');
fprintf(fileID,'%s\n',sepStr(stmt0));
fprintf(fileID,'%s\n',sepStr(stmt1));
fprintf(fileID,'%s\n',sepStr(stmt2));
fprintf(fileID,'%s\n',sepStr(stmt3));
fprintf(fileID,'%s\n',sepStr(stmt4));
fclose(fileID);

[~,~] = system([FijiExe ' --headless -macro "' sepStr([tbd_filepath '\']) name '_lsm2mhd.ijm"']);
[~,~] = system([ 'del  /Q  "' [tbd_filepath '\'] name '_lsm2mhd.ijm"']);
end
