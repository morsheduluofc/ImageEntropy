function  [tgScaleAvgImgData,tgScaleAvgValue]=gScaleAveragingF(ttrimImgData,tfinalASquareDim,tgScaleWTable)
%Input: Trim image data, final A square side length and linear averaging table.
%Output: Image data replaced by average weighted value and all average value of different squares.  
%Process:

[tImgW,tImgH]=size(ttrimImgData);
%gScalearray=table2dataset(tgScaleWTable);

%Step1: For every A square of the image
avgIndxW=1;
       % Step1(1): Separate all the pixels of a A square
for i=1:tfinalASquareDim:tImgW
    avgIndxH=1;
    for j=1:tfinalASquareDim:tImgH
        pixelStartW=i;
        pixelEndW= pixelStartW+tfinalASquareDim-1;
        pixelStartH=j;
        pixelEndH=pixelStartH+tfinalASquareDim-1;
        %fprintf('%d %d %d %d\n', pixelStartW,pixelEndW,pixelStartH,pixelEndH);
        %
        %ACount=count(TImg( pixelStartW:pixelEndW,pixelStartH:pixelEndH));
        %fprintf('%d %d\n',Asum,ACount);
        %ASquareAvg(i,fix(j/4)+1)=floor(Asum/ACount);
        %TSum=0;
        %ACount=0;
        %class(ASum)
        allPixelInASquare=ttrimImgData(pixelStartW:pixelEndW,pixelStartH:pixelEndH);
        
        %Step1(2): Count the number of pixels
        totalPixelInASquare=numel(ttrimImgData(pixelStartW:pixelEndW,pixelStartH:pixelEndH));
        [tASquareW,tASquareH]=size(allPixelInASquare);
        
        %Step1 (3): Multiply a predefined weight withe all pixels.
        for Ai=1:tASquareW
            for Aj=1:tASquareH
              pixelValue=allPixelInASquare(Ai,Aj)+1;
              %disp(pixelValue);
              pixelWeight=tgScaleWTable(pixelValue,2);
              allPixelInASquare(Ai,Aj)=allPixelInASquare(Ai,Aj)*pixelWeight;  
            end
        end  
        
        %Step1 (4): Sum the weighted value and then take their average.
        sumOfASquare=sum(sum(allPixelInASquare(1:tASquareW,1:tASquareH)));
        %{
        for k= pixelStartW:pixelEndW
            for l=pixelStartH:pixelEndH
                %TSum=TSum+TImg(k,l);
                ACount=ACount+1;
                %fprintf('%d %d %d\n',TSum,TImg(k,l),ACount);
            end
        end
        %}
        %fprintf('%d %d\n',TSum,ACount);
        
        %Step1 (5): Assign the average value to all pixel of a A square
        tgScaleAvgValue(avgIndxW,avgIndxH)=ceil(sumOfASquare/totalPixelInASquare);
        
        %X = [num2str(sumOfASquare), ' ',num2str(totalPixelInASquare),' ',num2str(tgScaleAvgValue(avgIndxW,avgIndxH))];
        %disp(X);
        
        for Gi= pixelStartW: pixelEndW
            for Gj=pixelStartH: pixelEndH
             tgScaleAvgImgData(Gi,Gj)= tgScaleAvgValue(avgIndxW,avgIndxH);
            end
        end
     
      avgIndxH=avgIndxH+1; 
      
    end
     avgIndxW=avgIndxW+1;
end
%imshow(ASquareAvg);
%histogram(ASquareAvg);
end