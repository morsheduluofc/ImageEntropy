function [tTrimImgData,tTrimImgIndx,tFinalASquareSide] = trimImageF(grayScaleImgData,sCircleDiameter)
%Input:Grayscale image data and the diameter of spot circle meter
%Output: Trim image data, index of all A square in trim image data and the length of final A square.
%side length
%Processes:

%Step1: If diameter of the spot meter is odd we change to even by subtracting a pixel value.
if(rem(sCircleDiameter,2)==1)
    %disp(sCircleDiameter);
    sCircleDiameter=sCircleDiameter-1;
end
%disp(sCircleDiameter);

%Step2: Store all even diameter length of spot circle diameter for its 100% to 75%-pixel value.
mintsCDiameter=floor(75/100*sCircleDiameter);
if(rem(mintsCDiameter,2)==1)
    %disp(sCircleDiameter);
    mintsCDiameter=mintsCDiameter-1;
end
%disp(mintsCDiameter)


[tGrayScaleImgW,tGrayScaleImgH]=size(grayScaleImgData);

%---------------------Process 1--------------------------------
%Step 3: Calculate the total number of dropped pixels for the different lengths of A square... 
% measured from spot circle diameters and take that length that has minimum pixel loss.
minPixelDrop=tGrayScaleImgW*tGrayScaleImgH;
for i=mintsCDiameter:2:sCircleDiameter
noOfASquareInW=floor(tGrayScaleImgW/i);
noOfASquareInH=floor(tGrayScaleImgH/i);
%disp(i);
%disp(tGrayScaleImgW*(tGrayScaleImgW-i*noOfASquareInW)+tGrayScaleImgH*(tGrayScaleImgH-i*noOfASquareInH));
if(tGrayScaleImgW*(tGrayScaleImgW-i*noOfASquareInW)+tGrayScaleImgH*(tGrayScaleImgH-i*noOfASquareInH)<minPixelDrop)
totalTrimPixelInW=tGrayScaleImgW-i*noOfASquareInW;
totalTrimPixelInH=tGrayScaleImgH-i*noOfASquareInH;
finalNoOfASquareInW=floor(tGrayScaleImgW/i);
finalNoOfASquareInH=floor(tGrayScaleImgH/i);
tFinalASquareSide=i;
minPixelDrop=tGrayScaleImgW*(tGrayScaleImgW-i*noOfASquareInW)+tGrayScaleImgH*(tGrayScaleImgH-i*noOfASquareInH);
end
end
%-----------------End Process 1-------------------------------

%-----------------Process 2------------------------------------
%Step 4: Measure the number of pixel that need to be dropped from left, right, top and bottom.
if(rem(totalTrimPixelInW,2)==1)
    lTotalTrimPixelInW=floor(totalTrimPixelInW/2);
    rTotalTrimPixelInW= lTotalTrimPixelInW+1;
else
    lTotalTrimPixelInW=totalTrimPixelInW/2;
    rTotalTrimPixelInW= lTotalTrimPixelInW;
end
%fprintf('%d, %d \n', lTotalTrimPixelInW,rTotalTrimPixelInW);
if(rem(totalTrimPixelInH,2)==1)
    lTotalTrimPixelInH=floor(totalTrimPixelInH/2);
    rTotalTrimPixelInH= lTotalTrimPixelInH+1;
else
    lTotalTrimPixelInH=totalTrimPixelInH/2;
    rTotalTrimPixelInH= lTotalTrimPixelInH;
end
%fprintf('%d, %d \n', lTotalTrimPixelInH,rTotalTrimPixelInH);
%-----------------End Process 2------------------------------

%--------------------Process 3-------------------------------
%Step 5: Calculate the index of all A square side and they be a 1 by 4 matrix. 
pixelW=lTotalTrimPixelInW+1;
for i=1:finalNoOfASquareInW
    pixelH=lTotalTrimPixelInH+1;
    for j=1:finalNoOfASquareInH
      %ASquareImg=gImg(pixelW:pixelW+sCircleDiameter-1,pixelH:pixelH+sCircleDiameter-1);
      %fprintf('%d %d %d %d\n',pixelW,pixelW+sCircleDiameter-1,pixelH,pixelH+sCircleDiameter-1);
      %Name=strcat('images/TrimImage/ASquare',num2str(i),num2str(j),'.PNG');
      %imwrite(ASquareImg,Name);
      tTrimImgIndx(i,4*(j-1)+1)=pixelW;
      tTrimImgIndx(i,4*(j-1)+2)=pixelW+tFinalASquareSide-1;
      tTrimImgIndx(i,4*(j-1)+3)=pixelH;
      tTrimImgIndx(i,4*(j-1)+4)=pixelH+tFinalASquareSide-1;
      pixelH=pixelH+tFinalASquareSide;
    end
     pixelW=pixelW+tFinalASquareSide;
end

%X=['Width',num2str(sCircleDiameter*noOfASquareInW),' Height',num2str(sCircleDiameter*noOfASquareInH)];
%disp(X);
%--------------------End Process 3-------------------------------

%Trim the image from grayscale image by start and end index
tTrimImgData=grayScaleImgData(lTotalTrimPixelInW+1:lTotalTrimPixelInW+tFinalASquareSide*finalNoOfASquareInW,lTotalTrimPixelInH+1:lTotalTrimPixelInH+tFinalASquareSide*finalNoOfASquareInH);
%disp(lTotalTrimPixelInH+sCircleDiameter*noOfASquareInH);
%imshow(tTrimImgData);
%folder = 'TrimImage';
%imwrite(tTrimImgData,fullfile(folder,'TrimImage.PNG'));
end