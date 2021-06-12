function tsCircleDiameter=sCircleDiameterF(tinputMetArea,tmetScalFactor,tgrayScaleImgH,tgrayScaleImgW)
%Input: Input meter area and scaling factor
%Output: Diameter of spot meter circle
% Process: 

PI=3.141;
totalImgSize=tgrayScaleImgH*tgrayScaleImgW;
%Step1: Area of the spot circle is measured by taking a predefined percentage of total pixel (meter area) of an image and then divide it by scale factor.
areaOfSpotC=((totalImgSize/100)*tinputMetArea)/tmetScalFactor;

%Step 2: We then measure the diameter of the circle by using equation area=?r^2.
tsCircleDiameter=2*ceil(sqrt(areaOfSpotC/PI));
%ASquare=diameter*diameter;
end