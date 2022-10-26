function printformask(filename, maskfilename)

[filepath name ext] = fileparts(filename);
line1 = ['run("Select path", "inputfile=' sepStr(filename) '");'];
line2 = ['selectWindow("' name ext '");'];
line3 = ['makeRectangle(55, 355, 150, 131);'];
line4 = ['run("Crop");'];
line5 = ['setOption("BlackBackground", false);'];
line6 = ['run("Convert to Mask", "method=Triangle background=Default calculate black create");'];
line7 = ['saveAs("Tiff", "' sepStr([maskfilename '\Mask_' name ext]) '");'];
line8 = ['close();'];
line9 = ['selectWindow("' name ext '");'];
line10 = ['close();'];


fprintf("%s\n", line1);
fprintf("%s\n", line2);
fprintf("%s\n", line3);
fprintf("%s\n", line4);
fprintf("%s\n", line5);
fprintf("%s\n", line6);
fprintf("%s\n", line7);
fprintf("%s\n", line8);
fprintf("%s\n", line9);
fprintf("%s\n", line10);

fprintf("\n");
end