function [tEntropy,tindEntropy,tFreqValue]=gScaleEntropyF(tGSCImage)
[tImgW,tImgH]=size(tGSCImage);
 totalPixel=tImgW*tImgH;
 tEntropy=0;
 
 for pixVal=0:255
     noOfPixel=0;
     for i=1:tImgW
         for j=1:tImgH
             if(tGSCImage(i,j)==pixVal)
                 noOfPixel=noOfPixel+1;
             end
         end
     end
     tFreqValue(pixVal+1,1)= pixVal;
     tFreqValue(pixVal+1,2)= noOfPixel;
     prob= noOfPixel/totalPixel;
     if(prob~=0)
     tEntropy=tEntropy+prob*log2(prob);
     tindEntropy(pixVal+1,1)=pixVal;
     tindEntropy(pixVal+1,2)=round(-(prob*log2(prob)),3);
    else
     tindEntropy(pixVal+1,1)=pixVal;
     tindEntropy(pixVal+1,2)=0;
     end
 end
 tEntropy=round(-tEntropy,3);
end