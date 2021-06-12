function [IndEntropy,FValue]=rmoveUnwantedData(tIndEntropy,tFValue,zTable)
uniqueValue = unique(zTable(:,2));
for i=1:length(uniqueValue)
    k = find(tIndEntropy(:,1)==uniqueValue(i));
    IndEntropy(i,1)=tIndEntropy(k,1);
    IndEntropy(i,2)=tIndEntropy(k,2);
    FValue(i,1)=tFValue(k,1);
    FValue(i,2)=tFValue(k,2);
end

end