function mainFunction(grayImg,imgName,sCDiameter,handles)
%Read an image
%imgName='grayscale.jpg';
%pathName=['images/',imgName];
%rawImg=imread(pathName);
%create a output folder
splitimgName=strsplit(imgName,'.');
%outPutFolder=[char(splitimgName(1)),'_Out'];
outPutFolder=[char(splitimgName(1)),'_Out'];
mkdir (outPutFolder);

k=7;

%Trim image
[TImage,TImgIndx,FsCDiameter]=TrimImage(grayImg,sCDiameter);
pathName=[outPutFolder,'/','TrimImage.PNG'];
axes(handles.axes2)
imshow(TImage)
imwrite(TImage,pathName);

i=1;
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finish:',num2str(round(100*i/k)),'%']);
pause(0.101)
    

%Convert it to gray scale and calculate weight and height
%grayImg = rgb2gray(rawImg);
%[ImgW,ImgH]=size(grayImg);


%Measure diamter of spot meter circle
%metArea=2.0;
%metScFactor=2.0;
%sCDiameter=ASquareCal(metArea,metScFactor,ImgH,ImgW);





%Calculate gray scale average for A Square
if(handles.csvDFile1==0)
gScaleWTable=csvread('images/LinearAveragingTable.csv',1,0);  
else
gScaleWTable=handles.csvDFile1;
end

[GSCImage,GScAberage]=GrayScaleAverage(TImage,FsCDiameter,gScaleWTable);
pathNameG=[outPutFolder,'/','GScaleAvg.PNG'];
pathNameH=[outPutFolder,'/','GScaleAvgHist.PNG'];
imGrayScale=mat2gray(GSCImage);
axes(handles.axes2)
imshow(imGrayScale)
imwrite(imGrayScale,pathNameG);
%imwrite(GSCImage,pathNameG);

i=2;
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finish:',num2str(round(100*i/k)),'%']);
pause(0.101)


%saveName='Hist.PNG';
%figure;
%h=histcounts(GSCImage);
%h=histogram(GSCImage);
set(gca,'XTickLabel',[],'YTickLabel',[]);
axes(handles.axes2)
%imshow(imGrayScale)
saveas(histogram(GSCImage),pathNameH,'png');
%Calculate Entropy of GrayScale Image
[Entropy,FreqValue]=GScEntropy(GSCImage);
pathNameG=[outPutFolder,'/','FrequencyValue.csv'];
title ={'Greyscale Value' ,'Frequency'};
%output = table(title, FreqValue);
csvwrite(pathNameG,FreqValue);

i=3;
set(handles.text9, 'String', num2str(round(Entropy,2)));
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finish:',num2str(round(100*i/k)),'%']);
pause(0.101)


%Zone Mapping
%Calculate gray scale average for A Square
if(handles.csvDFile2==0)
ZoneTable=csvread('images/ZoneTable.csv',1,0);
else
ZoneTable=handles.csvDFile2;
end
[ZTImage,ZTAberage]=ZoneTableAverage(TImage,FsCDiameter,ZoneTable);
pathNameG=[outPutFolder,'/','ZoneTableAvg.PNG'];
pathNameH=[outPutFolder,'/','ZoneTableAvgHist.PNG'];
imZTScale=mat2gray(ZTImage);
axes(handles.axes2)
imshow(imZTScale)
imwrite(imZTScale,pathNameG);

i=4;
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finish:',num2str(round(100*i/k)),'%']);
pause(0.101)


%saveName='Hist.PNG';
%figure;
%h=histogram(ZTImage);
set(gca,'XTickLabel',[],'YTickLabel',[]);
axes(handles.axes2)
%imshow(histogram(ZTImage));
saveas(histogram(ZTImage),pathNameH,'png');
i=5;
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finish:',num2str(round(100*i/k)),'%']);
pause(0.101)


axes(handles.axes2)
imshow(imZTScale)


%Calculate Entropy of GrayScale Image
[ZTEntropy,ZTFreqValue]=ZTableEntropy(ZTImage);
pathNameG=[outPutFolder,'/','ZTFrequencyValue.csv'];
title ={'Greyscale Value' ,'Frequency'};
%output = table(title, FreqValue);
csvwrite(pathNameG,ZTFreqValue);


i=6;
set(handles.text10, 'String', num2str(round(ZTEntropy,2)));
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finish:',num2str(round(100*i/k)),'%']);
pause(0.11)



%Weighted Zone
[tZTBlockEntropy,ZTBlockFreqValue]=WeightedZone(ZTImage,FsCDiameter,ZTAberage);
pathNameG=[outPutFolder,'/','ZTBlockFrequencyValue.csv'];
title ={'Greyscale Value' ,'Frequency'};
%output = table(title, FreqValue);
csvwrite(pathNameG,ZTBlockFreqValue);

i=7;
set(handles.text11, 'String', num2str(round(tZTBlockEntropy,2)));
axes(handles.axes3)
cla
rectangle('Position',[0,0,1001-(round(1000*i/k)),20],'FaceColor','b');
text(420,10,['Remaining:',num2str(100-round(100*i/k)),'%']);
axes(handles.axes4)
cla
rectangle('Position',[0,0,(round(1000*i/k))+1,20],'FaceColor','r'); 
text(420,10,['Finish:',num2str(round(100*i/k)),'%']);
pause(0.11)

end