function remove_background(filename, dst_folder)

rootpath = 'D:\Harsha\Repository\larvalign\source\larvalign';
exeDir = [rootpath '\resources\exe\'];
c3d = ['"' exeDir 'c3d.exe" '];

[dir, src_file, ext] = fileparts(filename);

src = [dir '\' src_file ext];
dst = [dir '\' dst_folder '\' src_file ext];
% Background correction 

%{
[~,cmdout] = system([ c3d '"' src '"  -info-full ']);                             
Ctmp=textscan(cmdout,'%s','Delimiter',{'  Mean Intensity     : '});
lowclip=num2str(ceil(cell2mat(textscan(Ctmp{1,1}{7,1},'%f'))));  
%}

img = read_tiff_stack(src);
mean_intensity = mean(img, "all");
lowclip=num2str(ceil(mean_intensity));
fprintf("lowclip of %s: %s\n", src_file, lowclip);
cmd = [  c3d '"' src '"  -clip ' lowclip ' 255  -replace ' lowclip ' 0  -type uchar -o "' dst '"' ];
[status,~] = system(cmd);  
assert(status==0, 'Processing failure.')
end