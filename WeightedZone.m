function  [tZTBlockEntropy,tindZTBlockEntropy,tBlockFreqValue]=WeightedZone(tZTImage,tFsCDiameter,tZTAberage)
[tZTImgW,tZTImgH]=size(tZTImage);
tFsCDiameterHalf=tFsCDiameter/2;
noOfBlockW=0;
noOfBlockH=0;
for i=1:tFsCDiameterHalf:tZTImgW
    if(i+tFsCDiameter-1 <=tZTImgW)
        noOfBlockW=noOfBlockW+1;
    end
end
for i=1:tFsCDiameterHalf:tZTImgH
    if(i+tFsCDiameter-1 <=tZTImgH)
        noOfBlockH=noOfBlockH+1;
    end
end
totalBlock=noOfBlockW*noOfBlockH;
%disp(noOfBlockW);
%disp(noOfBlockH);
%disp(totalBlock);
[tZTAvgW,tZTAvgH]=size(tZTAberage);
for i=1:tZTAvgW
    for j=1:tZTAvgH
       tZTSubAberage(2*i-1,2*j-1)=tZTAberage(i,j);
       tZTSubAberage(2*i-1,2*j)=tZTAberage(i,j);
       tZTSubAberage(2*i,2*j-1)=tZTAberage(i,j);
       tZTSubAberage(2*i,2*j)=tZTAberage(i,j);
    end
end
%disp(size(tZTSubAberage));
[tZTSubW,tZTSubH]=size(tZTSubAberage);

iIndx=1;
for i=1:tZTSubW
    jIndx=1;
    for j=1:tZTSubH
    if(i <tZTSubW && j <tZTSubH)
        avgZTBlockValue(iIndx,jIndx)= tZTSubAberage(i,j)+tZTSubAberage(i,j+1)+ tZTSubAberage(i+1,j)+tZTSubAberage(i+1,j+1);
        jIndx=jIndx+1;
    end
    end
    iIndx=iIndx+1;
end
%disp(size(avgZTBlockValue));

[validBlockValueW,validBlockValueH]=size(tZTSubAberage);
%disp(avgZTBlockValue);
%disp(avgZTBlockValue);
tZTBlockEntropy=0;
for avgBlockVal=0:10
     noOfBlock=0;
     for i=1:validBlockValueW-1
         for j=1:validBlockValueH-1
             if(tZTSubAberage(i,j)==avgBlockVal && tZTSubAberage(i,j+1)==avgBlockVal && tZTSubAberage(i+1,j)==avgBlockVal && tZTSubAberage(i+1,j+1)==avgBlockVal)
                 noOfBlock=noOfBlock+1;
             end
         end
     end
     tBlockFreqValue(avgBlockVal+1,1)= avgBlockVal;
     tBlockFreqValue(avgBlockVal+1,2)= noOfBlock;
     prob= noOfBlock/totalBlock;
     if(prob~=0)
     tZTBlockEntropy=tZTBlockEntropy+prob*log2(prob);
     tindZTBlockEntropy(avgBlockVal+1,1)=avgBlockVal;
     tindZTBlockEntropy(avgBlockVal+1,2)=round(-(prob*log2(prob)),3);
     else
     tindZTBlockEntropy(avgBlockVal+1,1)=avgBlockVal;
     tindZTBlockEntropy(avgBlockVal+1,2)=0;    
     end
 end
 tZTBlockEntropy=round(-tZTBlockEntropy,3);
 
end