function [tZTEntropy,tindZTEntropy,tFreqValue]=ZTableEntropy(tZTableImage)
[tImgW,tImgH]=size(tZTableImage);
 totalPixel=tImgW*tImgH;
 %disp(totalPixel);
 tZTEntropy=0;
 
 for pixVal=0:10
     noOfPixel=0;
     for i=1:tImgW
         for j=1:tImgH
             if(tZTableImage(i,j)==pixVal)
                 noOfPixel=noOfPixel+1;
             end
         end
     end
     tFreqValue(pixVal+1,1)= pixVal;
     tFreqValue(pixVal+1,2)= noOfPixel;
     prob= noOfPixel/totalPixel;
     if(prob~=0)
     tZTEntropy=tZTEntropy+prob*log2(prob);
     tindZTEntropy(pixVal+1,1)=pixVal;
     tindZTEntropy(pixVal+1,2)=round(-(prob*log2(prob)),3);
     else
     tindZTEntropy(pixVal+1,1)=pixVal;
     tindZTEntropy(pixVal+1,2)=0;
     end
 end
 tZTEntropy=round(-tZTEntropy,3);
end