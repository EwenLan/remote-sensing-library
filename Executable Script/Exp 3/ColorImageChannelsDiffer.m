img = imread('DJI_0027_Compressed.png');
newimg = ImageDiffer_Log(img(:,:,1), img(:,:,2));
newimg2 = ImageDiffer_Minus(img(:,:,1), img(:,:,2));
subplot(1, 2, 1);
imshow(newimg);
title('I_1=1-min(\mu)');