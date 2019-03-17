%% Filename: add_noise.m
% Add Gaussian Noise into the original image.
% Show the image and the image with Gaussian Noise.

img = rgb2gray(imread('DJI_0027_Compressed.png'));
imgsize = size(img);
noise = uint8(randn(imgsize) * 50);
img_noise = img + noise;
subplot(1, 2, 1);
imshow(img);
title('Original Image');
subplot(1, 2, 2);
imshow(img_noise);
title('Image with Gaussian Noise');
imwrite(img_noise, '../../Image Library/DJI_0027_With_Noise.png');
imwrite(img_noise, '../../Document/figure/DJI_0027_With_Noise.png');