function  [zMappedBlockEntropy,zMappedIndBlockEntropy,zMappedFValue]=wZoneTableAvgEntF(zMappedImg,finalASquareDim,zMappedAvg)

%Input: Zoned mapped image value, final A square side length and all average value of different squares
%Output: Total entropy for zone mapped block, entropy of individual zone mapped block, and frequency of individual zoned mapped block.

%Process:
  %Step1: Measure the toal number of block in the zoned image
[tZTImgW,tZTImgH]=size(zMappedImg);
  %Step1(1):Divide the A square side by 2.
finalASquareDimHalf=finalASquareDim/2;
  %Step1 (2):Count how many block in width and height of the image
noOfBlockW=0;
noOfBlockH=0;
for i=1:finalASquareDimHalf:tZTImgW
    if(i+finalASquareDim-1 <=tZTImgW)
        noOfBlockW=noOfBlockW+1;
    end
end
for i=1:finalASquareDimHalf:tZTImgH
    if(i+finalASquareDim-1 <=tZTImgH)
        noOfBlockH=noOfBlockH+1;
    end
end
  %Step1(3): Count total block
totalBlock=noOfBlockW*noOfBlockH;
%disp(noOfBlockW);
%disp(noOfBlockH);
%disp(totalBlock);

[tZTAvgW,tZTAvgH]=size(zMappedAvg);
for i=1:tZTAvgW
    for j=1:tZTAvgH
       tZTSubAverage(2*i-1,2*j-1)=zMappedAvg(i,j);
       tZTSubAverage(2*i-1,2*j)=zMappedAvg(i,j);
       tZTSubAverage(2*i,2*j-1)=zMappedAvg(i,j);
       tZTSubAverage(2*i,2*j)=zMappedAvg(i,j);
    end
end
%disp(size(tZTSubAverage));
[tZTSubW,tZTSubH]=size(tZTSubAverage);
%disp(tZTSubW);
%disp(tZTSubH);

%{
iIndx=1;
for i=1:tZTSubW
    jIndx=1;
    for j=1:tZTSubH
    if(i <tZTSubW && j <tZTSubH)
        avgZTBlockValue(iIndx,jIndx)= tZTSubAverage(i,j)+tZTSubAverage(i,j+1)+ tZTSubAverage(i+1,j)+tZTSubAverage(i+1,j+1);
        jIndx=jIndx+1;
    end
    end
    iIndx=iIndx+1;
end
%disp(size(avgZTBlockValue));
%}

[validBlockValueW,validBlockValueH]=size(tZTSubAverage);
%disp(validBlockValueW);
%disp(validBlockValueH);
zMappedBlockEntropy=0;
for avgBlockVal=0:255
     noOfBlock=0;
     %loop=0;
     for i=1:validBlockValueW-1
         for j=1:validBlockValueH-1
             %loop=loop+1;
             if(tZTSubAverage(i,j)==avgBlockVal & tZTSubAverage(i,j+1)==avgBlockVal & tZTSubAverage(i+1,j)==avgBlockVal & tZTSubAverage(i+1,j+1)==avgBlockVal)
                 noOfBlock=noOfBlock+1;
             end
         end
     end
     %disp(noOfBlock);
     zMappedFValue(avgBlockVal+1,1)= avgBlockVal;
     zMappedFValue(avgBlockVal+1,2)= noOfBlock;
     prob= noOfBlock/totalBlock;
     if(prob~=0)
     zMappedBlockEntropy=zMappedBlockEntropy+prob*log2(prob);
     zMappedIndBlockEntropy(avgBlockVal+1,1)=avgBlockVal;
     zMappedIndBlockEntropy(avgBlockVal+1,2)=round(-(prob*log2(prob)),3);
     else
     zMappedIndBlockEntropy(avgBlockVal+1,1)=avgBlockVal;
     zMappedIndBlockEntropy(avgBlockVal+1,2)=0;    
     end
 end
 zMappedBlockEntropy=round(-zMappedBlockEntropy,3);
 
end