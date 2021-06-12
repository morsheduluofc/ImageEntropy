%{
prompt = {'Enter matrix size:','Enter colormap name:'};
title = 'Input';
dims = [1 35];
definput = {'20','hsv'};
answer = inputdlg(prompt,title,dims,definput)
%}
x = inputdlg({'Name','Telephone','Account'},'Customer', [1 50; 1 12; 1 7]); 