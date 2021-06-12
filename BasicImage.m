%Read image
Img=imread('images/BasicImage.PNG');
%Display image
 %imshow(Img);
%Information about image
 %whos Img
%Image histogram
  %figure
  %imhist(Img(:,:,1));
%Imptove the contrast of image
  %Img2=histeq(horzcat(Img(:,:,1),Img(:,:,2),Img(:,:,3)));
  %Img2=histeq([Img(:,:,1); Img(:,:,2); Img(:,:,3)]);
  %Img2=histeq(Img(:,:,1));
  %figure
  %imhist(Img2);
 %Show the image
 subplot(2,2,1)
   %Img1=histeq(Img(:,:,1));
   imshow(Img);
   hold on;
  subplot(2,2,2)
   Img1=histeq(Img(:,:,1));
   imshow(Img1);
   hold on;
   subplot(2,2,3)
   Img2=histeq(Img(:,:,2));
   imshow(Img2);
   hold on;
   subplot(2,2,4)
    Img3=histeq(Img(:,:,3));
   imshow(Img3);
 % write the image
  imwrite(Img1,'images/myimage.png')
 %Image Information
  Info=imfinfo('images/myimage.png');
  Info1=imfinfo('images/BasicImage.PNG');