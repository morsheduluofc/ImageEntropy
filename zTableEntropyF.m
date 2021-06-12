function [zMappedEntropy,zMappedIndEntropy,zMappedFValue]=zTableEntropyF(zMappedImgData)

%Input: Zoned mapped image value  
%Output: Total Entropy for zone mapped image, entropy of individual zone mapped pixel value and frequency of individual zoned mapped pixel value.
%Process:
  %Step1: For every zone value
  
[tImgW,tImgH]=size(zMappedImgData);
totalPixel=tImgW*tImgH;
 %disp(totalPixel);
zMappedEntropy=0;
 
%Step1(1): Count the number of pixel in the image and measure their probability
 for pixelVal=0:255
     noOfPixel=0;
     for i=1:tImgW
         for j=1:tImgH
             if(zMappedImgData(i,j)==pixelVal)
                 noOfPixel=noOfPixel+1;
             end
         end
     end
     zMappedFValue(pixelVal+1,1)= pixelVal;
     zMappedFValue(pixelVal+1,2)= noOfPixel;
     prob= noOfPixel/totalPixel;
     
     %Step1(2): Measure the entropy of every pixel value
     %Step1(3): Measure the entropy of all pixel
     if(prob~=0)
     zMappedEntropy=zMappedEntropy+prob*log2(prob);
     zMappedIndEntropy(pixelVal+1,1)=pixelVal;
     zMappedIndEntropy(pixelVal+1,2)=round(-(prob*log2(prob)),3);
     else
     zMappedIndEntropy(pixelVal+1,1)=pixelVal;
     zMappedIndEntropy(pixelVal+1,2)=0;
     end
 end
 zMappedEntropy=round(-zMappedEntropy,3);
end