%------------------------------------------------------------
% This is the main function of this project. Program will
% start from here.
%------------------------------------------------------------


%-------------------------Process 1--------------------------
%Read a source image
%sourceImgName='watefall camping TS 2.png';
%sourceImgFolderName='inputData';
%sourceImgPathName=[sourceImgFolderName,'/',sourceImgName];

sourceImgFolderName='allImages';
MyFolderInfo = dir(sourceImgFolderName);
sourceImgName=MyFolderInfo(3).name
sourceImgPathName=[sourceImgFolderName,'/',sourceImgName]

[rawImgData,map]=imread(sourceImgPathName);
I0=entropy(rawImgData);
Output=['Original Image Entropy(Function):',num2str(I0),' bits'];
disp(Output);
%Convert the image to gray scale and calculate its weight and height
grayScaleImgData = rgb2gray(rawImgData);
[grayScaleImgW,grayScaleImgH]=size(grayScaleImgData);

%Create an output folder
splitSourceImgName=strsplit(sourceImgName,'.');
outputFolderName=[char(splitSourceImgName(1)),'_Out'];
mkdir (outputFolderName);
%----------------------End Process 1------------------------



%-------------------------Process 2--------------------------
%Measure the diamter of spot meterring circle
inputMetArea=2.0;
metScalFactor=2;
sCircleDiameter=sCircleDiameterF(inputMetArea,metScalFactor,grayScaleImgH,grayScaleImgW);
%----------------------End Process 2------------------------


%-------------------------Process 3--------------------------
%Trim source image
[trimImgData,trimImgIndx,finalASquareDim]=trimImageF(grayScaleImgData,sCircleDiameter);
trimImgName=[char(splitSourceImgName(1)),'_TRIM'];
trimImgName=[trimImgName,'.png'];
trimImgPathName=[outputFolderName,'/',trimImgName];
imwrite(trimImgData,trimImgPathName);
[trimImgW,trimImgH]=size(trimImgData);
%---------------------End Process 3--------------------------



%-------------------------Process 4--------------------------
%Gray scale averaging
gScaleWTableName='LinearAveragingTable.csv';
gScaleWTablePathName=[sourceImgFolderName,'/',gScaleWTableName];
gScaleWTable=csvread(gScaleWTablePathName,1,0);
[gScaleAvgImgData,gScaleAvgValue]=gScaleAveragingF(trimImgData,finalASquareDim,gScaleWTable);

%Gray scale ageraging image
gScaleAvgImgName=[char(splitSourceImgName(1)),'_GSA'];
gScaleAvgImgName=[gScaleAvgImgName,'.png'];
gScaleAvgImgPathName=[outputFolderName,'/',gScaleAvgImgName];
gScaleAvgImgDatatoImg=mat2gray(gScaleAvgImgData,[0,255]);
imwrite(gScaleAvgImgDatatoImg,gScaleAvgImgPathName);
%saveas(imshow(gScaleAvgImgData,[0,255]),gScaleAvgImgPathName,'png');
%saveas(gScaleAvgImgData,gScaleAvgImgPathName,'png');
%imshow(gScaleAvgImgData,[0 255]);
%Gray scale image averaging histogram
gScaleAvgImageHistName=[char(splitSourceImgName(1)),'_GSAH'];
gScaleAvgImageHistName=[gScaleAvgImageHistName,'.png'];
gScaleAvgImageHistPathName=[outputFolderName,'/',gScaleAvgImageHistName];
%imwrite(gScaleAvgImgData,gScaleAvgImgPathName);
%saveName='Hist.PNG';
%figure;
%h=histcounts(gScaleAvgImgData);
%h=histogram(gScaleAvgImgData);
saveas(histogram(gScaleAvgImgData,256),gScaleAvgImageHistPathName,'png');


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
%---------------------End Process 4--------------------------


%-----------------------Process 5----------------------------
%Zone Mapping
zTableName='ZoneTable1.csv';
zTableFPath=[sourceImgFolderName,'/',zTableName];
zTable=csvread(zTableFPath,1,0);
zMappedImg=ASquareZTableAvgF1(gScaleAvgImgData,finalASquareDim,zTable);

%Zone mapped image
zMappedImgName=[char(splitSourceImgName(1)),'_ZM'];
zMappedImgName=[zMappedImgName,'.png'];
zMappedImgPathName=[outputFolderName,'/',zMappedImgName];
zImgDatatoImg=mat2gray(zMappedImg,[0,255]);
imwrite(zImgDatatoImg,zMappedImgPathName);
%ZImage=imshow(zMappedImg);
%saveas(imshow(zMappedImg,[0,255]),zMappedImgPathName,'png');
%Zone mapped histogram
zImgHistName=[char(splitSourceImgName(1)),'_ZMH'];
zImgHistName=[zImgHistName,'.png'];
zImgHistPathName=[outputFolderName,'/',zImgHistName];
%saveName='Hist.PNG';
%figure;
%h=histogram(zMappedImg);
saveas(histogram(zMappedImg,256),zImgHistPathName,'png');


%Calculate the zone mapped image frequencey and entropy
[zMappedEntropy,zMappedIndEntropy,zMappedFValue]=zTableEntropyF(zMappedImg);
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
csvwrite(zMappedImgPathName,zMappedFValue);
%Zone Mapped Entropy table
zImgIndETableName=[char(splitSourceImgName(1)),'_ZME'];
zImgIndETableName=[zImgIndETableName,'.csv'];
zMappedImgPathName=[outputFolderName,'/',zImgIndETableName];
csvwrite(zMappedImgPathName,zMappedIndEntropy);
%---------------------End Process 5-----------------------

%------------------------Process 6------------------------
%Weighted Zone mapping
[zMappedBlockEntropy,zMappedIndBlockEntropy,zMappedFValue]=wZoneTableAvgEntF(zMappedImg,finalASquareDim,zMappedAvg);
Output=['Weighted Zonned Mapped Image Entropy:',num2str(zMappedBlockEntropy),' bits'];
disp(Output);
zMappedBlockFTableName=[char(splitSourceImgName(1)),'_ZMWF'];
zMappedBlockFTableName=[zMappedBlockFTableName,'.csv'];
zMappedBlockFPathName=[outputFolderName,'/',zMappedBlockFTableName];
%title ={'Greyscale Value' ,'Frequency'};
%output = table(title, gScaleAvgIndFValue);
csvwrite(zMappedBlockFPathName,zMappedFValue);

zMappedBlockEFName=[char(splitSourceImgName(1)),'_ZMWE'];
zMappedBlockEFName=[zMappedBlockEFName,'.csv'];
zMappedBlockFPathName=[outputFolderName,'/',zMappedBlockEFName];
csvwrite(zMappedBlockFPathName,zMappedIndBlockEntropy);
%-----------------------End Process 6--------------------------


%---------------------------Process 7--------------------------
metadataFileName=[char(splitSourceImgName(1)),'_MD'];
currentFolderPath = pwd;
%disp(currentFolderPath);
Index=[0;1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26;27;28;29;30];
Entry={'Output Metadata Table Version';'Source Image File Name';'Source Image File Path';...
    'Source Image File System Date';'Source Image x pixels';'Source Image y pixels';...
    'Source Image Type';'Greyscale Averaging Table File Path';'Greyscale Averaging Table File Name';...
    'Zone Mapping Table File Path';'Zone Mapping Table File Name';'Input Metering Area %';...
    'Meter Scaling Factor';'Calculated Metering Area Used';'A square side dimension';...
    'A square side dimension';'Output Folder Path';'Trimmed Image x pixels';'Trimmed Image y pixels';...
    'A Square Greyscale Averaged Image File Name';'A Square Greyscale Averaged Image Histogram File Name';...
    'A Square Greyscale Averaged Image Entropy Table File Name';'A Square Zone Mapped Image File Name';...
    'Zoned Image Histogram Table File Name';'Zoned Image Histogram Entropy Table File Name';...
    'Weighted Zoned Image Entropy Table File Name';'Run Metadata Output Table File Name';'Source Image Entropy';...
    'Grayscale Averaging Image Entropy';'Zonned Mapped Image Entropy';'Weighted Zonned Mapped Image Entropy'};
Type={'Integer';'String';'String';'String';'Integer';'Integer';'String';'String';'String';'String';'String';...
      'Float';'Integer';'Float';'Integer';'Integer';'String';'Integer';'Integer';'String';'String';'String';...
      'String';'String';'String';'String';'String';'bits';'bits';'bits';'bits'};
  
sourceImgPath=[currentFolderPath,'/',sourceImgFolderName];
sourceFInfo=dir(sourceImgPathName);
sourceImageDateTimeStamp={sourceFInfo.date};
outputFolderPath=[currentFolderPath,'/',outputFolderName];
gScaleFileName=strsplit(gScaleWTablePathName,'/');
zTableFName=strsplit(zTableFPath,'/');
metadataFileName=[metadataFileName,'.csv'];
gScaleAvgImgPathName=[outputFolderName,'/',metadataFileName];

Data={'v1';char(splitSourceImgName(1));sourceImgPath;sourceImageDateTimeStamp{1};grayScaleImgW;grayScaleImgH;...
     char(splitSourceImgName(2));outputFolderPath; gScaleFileName{2};outputFolderPath;zTableFName{2};...
     inputMetArea;metScalFactor;finalASquareDim*finalASquareDim;finalASquareDim;finalASquareDim;outputFolderPath;...
     trimImgW;trimImgH;gScaleAvgImgName;gScaleAvgFTableName;gScaleAvgIndETableName;zMappedImgName;zMappedFTableName;...
     zImgIndETableName;zMappedBlockEFName;metadataFileName;I0;I1;I2;zMappedBlockEntropy};
OutputMetaData=table(Index,Entry,Type,Data);
writetable(OutputMetaData,gScaleAvgImgPathName);
%pdfReport();
%------------------------ End Process 7 -------------------------
