img = imread('DJI_0027_Gray.png');
newimg = ReverseTransform(img);
subplot(1, 2, 1);
imshow(img);
title('Original Image');
subplot(1, 2, 2);
imshow(newimg);
title('Reversed Image');
imwrite(newimg, '../../Document/figure/DJI_0027_Reversed.png');