function t = writeToTable(mmi, brain, str_filepath)
vxm = mmi(1,:)';
cmp = mmi(2,:)';

dif = vxm - cmp;
name = brain';
t = table(name, vxm, cmp, dif);

fprintf("worst mmi from vxm: %d\n", min(vxm));
fprintf("worst mmi from cmp: %d\n", min(cmp));

writetable(t, [str_filepath '\mmi.csv']);
end