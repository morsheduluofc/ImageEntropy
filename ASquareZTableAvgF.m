function  [zMappedImgValue,zMappedAvgValue]=ASquareZTableAvgF(trimImgData,finalASquareDim,zTable)

%Input: Trim image data, final A square side length and zone table.
%Output: Zooned mapped image value and all average value of different squares.
%Process:
   %Step1: For every A square of the image
[tImgW,tImgH]=size(trimImgData);
%gScalearray=table2dataset(zTable);

  % Step1(1): Separate all the pixels of a A square
avgIndxW=1;
for i=1:finalASquareDim:tImgW
    avgIndxH=1;
    for j=1:finalASquareDim:tImgH
        pixelStartW=i;
        pixelEndW=pixelStartW+finalASquareDim-1;
        pixelStartH=j;
        pixelEndH=pixelStartH+finalASquareDim-1;
        %fprintf('%d %d %d %d\n',pixelStartW,pixelEndW,pixelStartH,pixelEndH);
        %
        %ACount=count(TImg(pixelStartW:pixelEndW,pixelStartH:pixelEndH));
        %fprintf('%d %d\n',Asum,ACount);
        %ASquareAvg(i,fix(j/4)+1)=floor(Asum/ACount);
        %TSum=0;
        %ACount=0;
        %class(ASum)
        allPixelInASquare=trimImgData(pixelStartW:pixelEndW,pixelStartH:pixelEndH);
        
        %Step1(2): Count the number of pixels
        totalPixelInASquare=numel(trimImgData(pixelStartW:pixelEndW,pixelStartH:pixelEndH));
        [tASquareW,tASquareH]=size(allPixelInASquare);
        
        %Step1 (3): Replace every pixel value by its zone value
        for Ai=1:tASquareW
            for Aj=1:tASquareH
              pixelValue=allPixelInASquare(Ai,Aj)+1;
              %disp(pixelValue);
              %tWeight=zTable(pixelValue,2);
              allPixelInASquare(Ai,Aj)=zTable(pixelValue,2);
            end
        end  
        %disp(allPixelInASquare(1:tASquareW,1:tASquareH));
       
        %Step1 (4): Sum the zoned value and then take their average.
         sumOfASquare=sum(sum(allPixelInASquare(1:tASquareW,1:tASquareH)));
        %disp(sumOfASquare);
        %{
        for k=pixelStartW:pixelEndW
            for l=pixelStartH:pixelEndH
                %TSum=TSum+TImg(k,l);
                ACount=ACount+1;
                %fprintf('%d %d %d\n',TSum,TImg(k,l),ACount);
            end
        end
        %}
        %fprintf('%d %d\n',TSum,ACount);
        
         %Step1 (5): Assign the average of zoned value to all pixel of a A square
        zMappedAvgValue(avgIndxW,avgIndxH)=ceil(sumOfASquare/totalPixelInASquare);
        for Gi=pixelStartW: pixelEndW
            for Gj=pixelStartH: pixelEndH
             zMappedImgValue(Gi,Gj)= zMappedAvgValue(avgIndxW,avgIndxH);
            end
        end
     
      avgIndxH=avgIndxH+1; 
      
    end
     avgIndxW=avgIndxW+1;
end
%imshow(ASquareAvg);
%histogram(ASquareAvg);
end