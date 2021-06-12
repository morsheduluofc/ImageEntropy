function mainFunction1(grayScaleImgData,orgImage,sourceImgFolderName,sourceImgName,sCircleDiameter,handles)
%------------------------------------------------------------
% This is the main function of this project. Program will
% start from here.
%------------------------------------------------------------


%-------------------------Process 1--------------------------
%Read a source image
%sourceImgName='Black.jpeg';
%sourceImgFolderName='inputData';
%sourceImgPathName=[sourceImgFolderName,'/',sourceImgName];
%rawImgData=imread(sourceImgPathName);

%Convert the image to gray scale and calculate its weight and height
%grayScaleImgData = rgb2gray(rawImgData);
%[grayScaleImgW,grayScaleImgH]=size(grayScaleImgData);
axes(handles.axes2)
imshow(orgImage)

I0=entropy(mat2gray(grayScaleImgData));
Output=['Original Image Entropy(Function):',num2str(I0),' bits'];
disp(Output);

%Create an output folder
splitSourceImgName=strsplit(handles.imgFileName,'.');
outputFolderName=[char(splitSourceImgName(1)),'_Out'];
mkdir (outputFolderName);
%----------------------End Process 1------------------------

k=7;
i=0;
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finished:',num2str(round(100*i/k)),'%']);
pause(0.101)

%-------------------------Process 2--------------------------
%Measure the diamter of spot meterring circle
%{
inputMetArea=2.0;
metScalFactor=2;
sCircleDiameter=sCircleDiameterF(inputMetArea,metScalFactor,grayScaleImgH,grayScaleImgW);
%}
%----------------------End Process 2------------------------


%-------------------------Process 3--------------------------


%Trim source image
[trimImgData,trimImgIndx,finalASquareDim]=trimImageF(grayScaleImgData,sCircleDiameter);
set(handles.textbox3,'String',finalASquareDim);
trimImgName=[char(splitSourceImgName(1)),'_TRIM'];
trimImgName=[trimImgName,'.png'];
trimImgPathName=[outputFolderName,'/',trimImgName];
axes(handles.axes2)
imshow(trimImgData)
imwrite(trimImgData,trimImgPathName);

%-------------------------------------------------------------
i=1;
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finished:',num2str(round(100*i/k)),'%']);
pause(0.101)


%---------------------End Process 3--------------------------



%-------------------------Process 4--------------------------
%Gray scale averaging
if(handles.linearAveragingDataFile==0)
gScaleWTableName='LinearAveragingTable.csv';
gScaleWTablePathName=[pwd,'/',gScaleWTableName];
gScaleWTable=csvread(gScaleWTablePathName,1,0);
else
gScaleWTable=handles.zTableDataFile;
end
[trimImgW,trimImgH]=size(trimImgData);
[gScaleAvgImgData,gScaleAvgValue]=gScaleAveragingF(trimImgData,finalASquareDim,gScaleWTable);

%Gray scale ageraging image
gScaleAvgImgName=[char(splitSourceImgName(1)),'_GSA'];
gScaleAvgImgName=[gScaleAvgImgName,'.png'];
gScaleAvgImgPathName=[outputFolderName,'/',gScaleAvgImgName];
gScaleAvgImgDatatoImg=mat2gray(gScaleAvgImgData,[0,255]);

imwrite(gScaleAvgImgDatatoImg,gScaleAvgImgPathName);

%Gray scale image averaging histogram
gScaleAvgImageHistName=[char(splitSourceImgName(1)),'_GSAH'];
gScaleAvgImageHistName=[gScaleAvgImageHistName,'.png'];
gScaleAvgImageHistPathName=[outputFolderName,'/',gScaleAvgImageHistName];
%imwrite(gScaleAvgImgData,gScaleAvgImgPathName);
%saveName='Hist.PNG';
%figure;
%h=histcounts(gScaleAvgImgData);
%ghist=imwrite(imhist(gScaleAvgImgData),gScaleAvgImageHistPathName);
%imhist(gScaleAvgImgDatatoImg);
axes(handles.axes2)
%saveas(bar(imhist(gScaleAvgImgData)),gScaleAvgImageHistPathName)
%horzg=unique(gScaleWTable(:,1));
%hfisg = figure('visible','off') ; bar(horzg,imhist(gScaleAvgImgDatatoImg,256));

%hfig = figure('visible','off') ; bar(imhist(gScaleAvgImgData));
%saveas(hfisg ,gScaleAvgImageHistPathName,'png')
%close(hfisg);
%saveas(histogram(gScaleAvgImgData,256),gScaleAvgImageHistPathName,'png');
axes(handles.axes2)
imshow(gScaleAvgImgDatatoImg)
%------------------------------------------------------------------------
i=2;
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finished:',num2str(round(100*i/k)),'%']);
pause(0.101)
%------------------------------------------------------------------------

%Calculate the gray scale averaging image frequencey and entropy
[gScaleAvgEntropy,gScaleAvgIndEntropy, gScaleAvgIndFValue]=gScaleAvgEntropyF(gScaleAvgImgData);
I1=entropy(gScaleAvgImgDatatoImg);
Output=['Grayscale Averaging Image Entropy(Function):',num2str(I1),' bits'];
disp(Output);
Output=['Grayscale Averaging Image Entropy:',num2str(gScaleAvgEntropy),' bits'];
disp(Output);
gScaleAvgFTableName=[char(splitSourceImgName(1)),'_GSAF'];
gScaleAvgFTableName=[gScaleAvgFTableName,'.csv'];
gScaleAvgImgPathName=[outputFolderName,'/',gScaleAvgFTableName];
%title ={'Greyscale Value' ,'Frequency'};
%output = table(title, gScaleAvgIndFValue);
csvwrite(gScaleAvgImgPathName,gScaleAvgIndFValue);
%A square Gray scale image entropy table
gScaleAvgIndETableName=[char(splitSourceImgName(1)),'_GSAE'];
gScaleAvgIndETableName=[gScaleAvgIndETableName,'.csv'];
gScaleAvgImgPathName=[outputFolderName,'/',gScaleAvgIndETableName];
csvwrite(gScaleAvgImgPathName,gScaleAvgIndEntropy);

%horz=unique(zTable(:,2));
axes(handles.axes2)
hfig1 = figure('visible','off') ; bar(gScaleAvgIndFValue(:,1),gScaleAvgIndFValue(:,2));
%hfig1 = imhist(zImgDatatoImg);
%zMappedImg

saveas(hfig1 ,gScaleAvgImageHistPathName,'png')
%imwrite(hfig1 ,zImgHistPathName);
close(hfig1);


%-----------------------------------------------------------------------
i=3;
set(handles.text9, 'String', num2str(round(gScaleAvgEntropy,3)));
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finished:',num2str(round(100*i/k)),'%']);
pause(0.101)
%---------------------End Process 4--------------------------


%-----------------------Process 5----------------------------
%Zone Mapping
if(handles.zTableDataFile==0)
zTableName='ZoneTable1.csv';
zTableFPath=[pwd,'/',zTableName];
zTable=csvread(zTableFPath,1,0);
else
zTable=handles.zTableDataFile;
end

[zMappedImg,zMappedAvg]=ASquareZTableAvgF1(gScaleAvgImgData,finalASquareDim,zTable);

%Zone mapped image
zMappedImgName=[char(splitSourceImgName(1)),'_ZM'];
zMappedImgName=[zMappedImgName,'.png'];
zMappedImgPathName=[outputFolderName,'/',zMappedImgName];
zImgDatatoImg=mat2gray(zMappedImg,[0,255]);
imwrite(zImgDatatoImg,zMappedImgPathName);

%------------------------------------------------------------------------
i=4;
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finished:',num2str(round(100*i/k)),'%']);
pause(0.101)
%------------------------------------------------------------------------

%Zone mapped histogram
zImgHistName=[char(splitSourceImgName(1)),'_ZMH'];
zImgHistName=[zImgHistName,'.png'];
zImgHistPathName=[outputFolderName,'/',zImgHistName];
%saveName='Hist.PNG';
%figure;
%histogram(zMappedImg);
%axes(handles.axes2)
%horz=unique(zTable(:,2));
%hfig1 = figure('visible','off') ; bar(horz,imhist(zImgDatatoImg,11));
%hfig1 = imhist(zImgDatatoImg);
%zMappedImg
%saveas(hfig1 ,zImgHistPathName,'png')
%imwrite(hfig1 ,zImgHistPathName);
%close(hfig1);
axes(handles.axes2)
imshow(zImgDatatoImg)
%saveas(histogram(zMappedImg,256),zImgHistPathName,'png');
%------------------------------------------------------------------------
i=5;
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finished:',num2str(round(100*i/k)),'%']);
pause(0.101)
%------------------------------------------------------------------------

%Calculate the zone mapped image frequencey and entropy
[zMappedEntropy,zMappedIndEntropy,zMappedFValue]=zTableEntropyF(zMappedImg);
[zMappedIndEntropyRm,zMappedFValueRm]=rmoveUnwantedData(zMappedIndEntropy,zMappedFValue,zTable);
I2=entropy(mat2gray(zImgDatatoImg));
Output=['Zonned Mapped Image Entropy(Function):',num2str(I2),' bits'];
disp(Output);
Output=['Zonned Mapped Image Entropy:',num2str(zMappedEntropy),' bits'];
disp(Output);
zMappedFTableName=[char(splitSourceImgName(1)),'_ZMF'];
zMappedFTableName=[zMappedFTableName,'.csv'];
zMappedImgPathName=[outputFolderName,'/',zMappedFTableName];
%title ={'Greyscale Value' ,'Frequency'};
%output = table(title, gScaleAvgIndFValue);
csvwrite(zMappedImgPathName,zMappedFValueRm);
%Zone Mapped Entropy table
zImgIndETableName=[char(splitSourceImgName(1)),'_ZME'];
zImgIndETableName=[zImgIndETableName,'.csv'];
zMappedImgPathName=[outputFolderName,'/',zImgIndETableName];
csvwrite(zMappedImgPathName,zMappedIndEntropyRm);

%horz=unique(zTable(:,2));
hfig2 = figure('visible','off') ; bar(zMappedFValueRm(:,1),zMappedFValueRm(:,2));
%hfig1 = imhist(zImgDatatoImg);
%zMappedImg
saveas(hfig2 ,zImgHistPathName,'png')
%imwrite(hfig1 ,zImgHistPathName);
close(hfig2);

%-------------------------------------------------------------------------
i=6;
set(handles.text10, 'String', num2str(round(zMappedEntropy,3)));
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finished:',num2str(round(100*i/k)),'%']);
pause(0.11)
%---------------------End Process 5-----------------------

%------------------------Process 6------------------------
%Weighted Zone mapping
[zMappedBlockEntropy,zMappedIndBlockEntropy,zMappedIndBlockFValue]=wZoneTableAvgEntF(zMappedImg,finalASquareDim,zMappedAvg);
[zMappedIndBlockEntropyRm,zMappedIndBlockFValueRm]=rmoveUnwantedData(zMappedIndBlockEntropy,zMappedIndBlockFValue,zTable);
Output=['Weighted Zonned Mapped Image Entropy:',num2str(zMappedBlockEntropy),' bits'];
disp(Output);
zMappedBlockFTableName=[char(splitSourceImgName(1)),'_ZMWF'];
zMappedBlockFTableName=[zMappedBlockFTableName,'.csv'];
zMappedBlockFPathName=[outputFolderName,'/',zMappedBlockFTableName];
%title ={'Greyscale Value' ,'Frequency'};
%output = table(title, gScaleAvgIndFValue);
csvwrite(zMappedBlockFPathName,zMappedIndBlockFValueRm);

zMappedBlockEFName=[char(splitSourceImgName(1)),'_ZMWE'];
zMappedBlockEFName=[zMappedBlockEFName,'.csv'];
zMappedBlockFPathName=[outputFolderName,'/',zMappedBlockEFName];
csvwrite(zMappedBlockFPathName,zMappedIndBlockEntropyRm);
%-----------------------------------------------------------------------
i=7;
set(handles.text11, 'String', num2str(round(zMappedBlockEntropy,3)));
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finished:',num2str(round(100*i/k)),'%']);
pause(0.11)

axes(handles.axes2)
imshow(orgImage)
%-----------------------End Process 6--------------------------


%---------------------------Process 7--------------------------
metadataFileName=[char(splitSourceImgName(1)),'_MD'];
entropyFileName='EntropyTable.csv';
currentFolderPath = pwd;
%disp(currentFolderPath);
MD_Index=[1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27];
Out_Index=[1;2;3;4;5];
MD_Title={'Output Metadata Table Version';'Source Image File Name';'Source Image File Path';...
    'Source Image File System Date';'Source Image x pixels';'Source Image y pixels';...
    'Source Image Type';'Greyscale Averaging Table File Path';'Greyscale Averaging Table File Name';...
    'Zone Mapping Table File Path';'Zone Mapping Table File Name';'Input Metering Area %';...
    'Meter Scaling Factor';'Calculated Metering Area';'A Square Side X Dimension';...
    'A Square Side Y Dimension';'Output Folder Path';'Trimmed Image Width (Pixels)';'Trimmed Image Height (Pixels)';...
    'A Square Grayscale Averaged Image File Name';'A Square Grayscale Averaged Image Histogram File Name';...
    'A Square Grayscale Averaged Image Entropy Table File Name';'A Square Zone Mapped Image File Name';...
    'Zone Mapped Image Histogram Table File Name';'Zoned Image Histogram Entropy Table File Name';...
    'Weighted Zoned Image Entropy Table File Name';'Metadata Output Table File Name'};
Out_Title={'Source Image Entropy';'Grayscale Averaging Image Entropy';'Zonne Mapped Image Entropy';...
        'Weighted Zonne Mapped Image Entropy';'Total Pixels in Trimed Image'};

MD_Type={'Integer';'String';'String';'String';'Integer';'Integer';'String';'String';'String';'String';'String';...
      'Float';'Integer';'Float';'Integer';'Integer';'String';'Integer';'Integer';'String';'String';'String';...
      'String';'String';'String';'String';'String'};
  
sourceImgPath=sourceImgFolderName;
sourceFInfo=dir(sourceImgFolderName);
sourceImageDateTimeStamp={sourceFInfo.date};
outputFolderPath=[currentFolderPath,'/',outputFolderName];
gScaleFileName=strsplit(gScaleWTablePathName,'/');
zTableFName=strsplit(zTableFPath,'/');
metadataFileName=[metadataFileName,'.csv'];
gScaleAvgImgPathName=[outputFolderName,'/',metadataFileName];
entropyPathName=[outputFolderName,'/',entropyFileName];

Metadata={'Version v1';char(splitSourceImgName(1));sourceImgPath;sourceImageDateTimeStamp{1};handles.grayScaleImgW;handles.grayScaleImgH;...
     char(splitSourceImgName(2));outputFolderPath; gScaleFileName{2};outputFolderPath;zTableFName{2};...
     handles.inputMetArea;handles.metScalFactor;finalASquareDim*finalASquareDim;finalASquareDim;finalASquareDim;outputFolderPath;...
     trimImgW;trimImgH;gScaleAvgImgName;gScaleAvgFTableName;gScaleAvgIndETableName;zMappedImgName;zMappedFTableName;...
     zImgIndETableName;zMappedBlockEFName;metadataFileName};

Entropy={I0;I1;I2;zMappedBlockEntropy;trimImgW*trimImgH};
OutputMetaData=table(MD_Index,MD_Title,MD_Type,Metadata);
OutputMetaData1=table(Out_Index,Out_Title,Entropy);
writetable(OutputMetaData,gScaleAvgImgPathName);
writetable(OutputMetaData1,entropyPathName);

%clear;

%pdfReport();
%------------------------ End Process 7 -------------------------
end