function  [zMappedImgValue,zMappedAvgValue]=ASquareZTableAvgF1(gScaleAvgImgData,finalASquareDim,zTable)
[tgImgW,tgImgH]=size(gScaleAvgImgData);

for i=1:tgImgW
    for j=1:tgImgH
        pixelValue=gScaleAvgImgData(i,j)+1;
        %disp(pixelValue);
        %tWeight=zTable(pixelValue,2);
       zMappedImgValue(i,j)=zTable(pixelValue,2);
    end
end


avgIndxW=1;
for i=1:finalASquareDim:tgImgW
    avgIndxH=1;
    for j=1:finalASquareDim:tgImgH
       zMappedAvgValue(avgIndxW,avgIndxH)=zMappedImgValue(i,j);
       avgIndxH=avgIndxH+1; 
    end
    avgIndxW=avgIndxW+1;
end

%noOfBin=unique(zTable(:,2));

end