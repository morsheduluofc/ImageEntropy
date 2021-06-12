function  [ZTImage,ZTAberage]=ZoneTableAverage(TImage,tFsCDiameter,ZoneTable)
[tImgW,tImgH]=size(TImage);
%gScalearray=table2dataset(ZoneTable);
avgIndxW=1;

for i=1:tFsCDiameter:tImgW
    avgIndxH=1;
    for j=1:tFsCDiameter:tImgH
        pixelStW=i;
        pixelEndW=pixelStW+tFsCDiameter-1;
        pixelStH=j;
        pixelEndH=pixelStH+tFsCDiameter-1;
        %fprintf('%d %d %d %d\n',pixelStW,pixelEndW,pixelStH,pixelEndH);
        %
        %ACount=count(TImg(pixelStW:pixelEndW,pixelStH:pixelEndH));
        %fprintf('%d %d\n',Asum,ACount);
        %ASquareAvg(i,fix(j/4)+1)=floor(Asum/ACount);
        %TSum=0;
        %ACount=0;
        %class(ASum)
        allPixelinASquareinZT=TImage(pixelStW:pixelEndW,pixelStH:pixelEndH);
        totalPixelinASquare=numel(TImage(pixelStW:pixelEndW,pixelStH:pixelEndH));
        [tAW,tAH]=size(allPixelinASquareinZT);
        for Ai=1:tAW
            for Aj=1:tAH
              tLoc=allPixelinASquareinZT(Ai,Aj)+1;
              %disp(tLoc);
              %tWeight=ZoneTable(tLoc,2);
              allPixelinASquareinZT(Ai,Aj)=ZoneTable(tLoc,2);
            end
        end  
        %disp(allPixelinASquareinZT(1:tAW,1:tAH));
        SumOfASquare=sum(sum(allPixelinASquareinZT(1:tAW,1:tAH)));
        %disp(SumOfASquare);
        %{
        for k=pixelStW:pixelEndW
            for l=pixelStH:pixelEndH
                %TSum=TSum+TImg(k,l);
                ACount=ACount+1;
                %fprintf('%d %d %d\n',TSum,TImg(k,l),ACount);
            end
        end
        %}
        %fprintf('%d %d\n',TSum,ACount);
        
        ZTAberage(avgIndxW,avgIndxH)=ceil(SumOfASquare/totalPixelinASquare);
        for Gi=pixelStW: pixelEndW
            for Gj=pixelStH: pixelEndH
             ZTImage(Gi,Gj)= ZTAberage(avgIndxW,avgIndxH);
            end
        end
     
      avgIndxH=avgIndxH+1; 
      
    end
     avgIndxW=avgIndxW+1;
end
%imshow(ASquareAvg);
%histogram(ASquareAvg);
end