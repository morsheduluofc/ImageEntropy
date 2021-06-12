%Read an image
imgName='grayscale.JPG';
pathName=['images/',imgName];
rawImg=imread(pathName);

%create a output folder
splitimgName=strsplit(imgName,'.');
outPutFolder=[char(splitimgName(1)),'_Out'];
mkdir (outPutFolder);


%Convert it to gray scale and calculate weight and height
grayImg = rgb2gray(rawImg);
[ImgW,ImgH]=size(grayImg);


%Measure diamter of spot meter circle
metArea=2.0;
metScFactor=2.0;
sCDiameter=ASquareCal(metArea,metScFactor,ImgH,ImgW);


%Trim image
[TImage,TImgIndx]=TrimImage(grayImg,sCDiameter);
pathName=[outPutFolder,'/','TrimImage.PNG'];
imwrite(TImage,pathName);


%Calculate gray scale average for A Square
gScaleWTable=readtable('images/LinearAveragingTable.csv');
GScAberage=GrayScaleAverage(TImage,TImgIndx,gScaleWTable);

%Read zone mapping table
%ZoneMapping = csvread('images/ZoneMappingTable.csv',1,0);

