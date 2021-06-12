function [TImage, ASquareIndex] = TrimImage(tgrayImg,tsCDiameter)

if(rem(tsCDiameter,2)==1)
    %disp(tsCDiameter);
    tsCDiameter=tsCDiameter-1;
end

%disp(tsCDiameter)
[tImgW,tImgH]=size(tgrayImg);
noOfSqW=floor(tImgW/tsCDiameter);
noOfSqH=floor(tImgH/tsCDiameter);

totalTrimPixelW=tImgW-tsCDiameter*noOfSqW;

if(rem(totalTrimPixelW,2)==1)
    LtotalTrimPixelW=floor(totalTrimPixelW/2);
    RtotalTrimPixelW= LtotalTrimPixelW+1;
else
    LtotalTrimPixelW=totalTrimPixelW/2;
    RtotalTrimPixelW= LtotalTrimPixelW;
end

totalTrimPixelH=tImgH-tsCDiameter*noOfSqH;

if(rem(totalTrimPixelH,2)==1)
    LtotalTrimPixelH=floor(totalTrimPixelH/2);
    RtotalTrimPixelH= LtotalTrimPixelH+1;
else
    LtotalTrimPixelH=totalTrimPixelH/2;
    RtotalTrimPixelH= LtotalTrimPixelH;
end
pixelW=LtotalTrimPixelW+1;
for i=1:noOfSqW-1
    pixelH=LtotalTrimPixelH+1;
    for j=1:noOfSqH-1
      %ASquareImg=gImg(pixelW:pixelW+tsCDiameter-1,pixelH:pixelH+tsCDiameter-1);
      %fprintf('%d %d %d %d\n',pixelW,pixelW+tsCDiameter-1,pixelH,pixelH+tsCDiameter-1);
      %Name=strcat('images/TrimImage/ASquare',num2str(i),num2str(j),'.PNG');
      %imwrite(ASquareImg,Name);
      ASquareIndex(i,4*(j-1)+1)=pixelW;
      ASquareIndex(i,4*(j-1)+2)=pixelW+tsCDiameter-1;
      ASquareIndex(i,4*(j-1)+3)=pixelH;
      ASquareIndex(i,4*(j-1)+4)=pixelH+tsCDiameter-1;
      pixelH=pixelH+tsCDiameter;
    end
     pixelW=pixelW+tsCDiameter;
end


%X=['Width',num2str(tsCDiameter*noOfSqW),' Height',num2str(tsCDiameter*noOfSqH)];
%disp(X);

TImage=tgrayImg(LtotalTrimPixelW+1:LtotalTrimPixelW+tsCDiameter*noOfSqW,LtotalTrimPixelH+1:LtotalTrimPixelH+tsCDiameter*noOfSqH);
%disp(LtotalTrimPixelH+tsCDiameter*noOfSqH);
%imshow(Timage);
%folder = 'TrimImage';
%imwrite(Timage,fullfile(folder,'TrimImage.PNG'));
end