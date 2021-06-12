function [gScaleAvgEntropy,gScaleAvgIndEntropy,gScaleAvgIndFValue]=gScaleAvgEntropyF(tgScaleAvgImgData)
%Input: Gray scale image weighted value  
%Output: Total Entropy for weighed gray scale image, entropy of individual weighted pixel value and frequency of individual pixel value.
%Process:
  %Step1: For every pixel value

[tImgW,tImgH]=size(tgScaleAvgImgData);
totalPixel=tImgW*tImgH;

gScaleAvgEntropy=0;
 
 %Step1(1): Count the number of pixel in the image and measure the probability
  for pixelVal=0:255
     noOfPixel=0;
     for i=1:tImgW
         for j=1:tImgH
             if(tgScaleAvgImgData(i,j)==pixelVal)
                 noOfPixel=noOfPixel+1;
             end
         end
     end
     
     gScaleAvgIndFValue(pixelVal+1,1)= pixelVal;
     gScaleAvgIndFValue(pixelVal+1,2)= noOfPixel;
     prob= noOfPixel/totalPixel;
     
     %Step1(2): Measure the entropy of every pixel value
     %Step1(3): Measure the entropy of all pixel
     if(prob~=0)
     gScaleAvgEntropy=gScaleAvgEntropy+prob*log2(prob);
     gScaleAvgIndEntropy(pixelVal+1,1)=pixelVal;
     gScaleAvgIndEntropy(pixelVal+1,2)=round(-(prob*log2(prob)),3);
    else
     gScaleAvgIndEntropy(pixelVal+1,1)=pixelVal;
     gScaleAvgIndEntropy(pixelVal+1,2)=0;
     end
 end
 gScaleAvgEntropy=round(-gScaleAvgEntropy,3);
end