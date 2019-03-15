img = imread('san_1.bmp');
newimg = ReverseTransform(img);
subplot(1, 2, 1);
imshow(img);
title('Original Image');
subplot(1, 2, 2);
imshow(newimg);
title('Reversed Image');