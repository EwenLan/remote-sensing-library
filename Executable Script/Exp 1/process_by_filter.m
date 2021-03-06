%% Filname: process_by_filter.m
% Process the image which has noise by filters and compare their
% performances.

oriimg = rgb2gray(imread('DJI_0027_Compressed.png'));
noiseimg = imread('DJI_0027_With_Noise.png');
meanimg = ImageMeanFilter(noiseimg, 2);
lpimg = ImageFrequencyDomainLowPassFilter(noiseimg, 0.5);
subplot(2, 2, 1);
imshow(noiseimg);
title('Image with Noise');
subplot(2, 2, 2);
imshow(oriimg);
title('Original Image');
subplot(2, 2, 3);
imshow(meanimg);
title('Processed by Mean Filter');
subplot(2, 2, 4);
imshow(lpimg);
title('Processed by Low-Pass Filter');

imwrite(oriimg, '../../Document/figure/DJI_0027_Gray.png');
imwrite(meanimg, '../../Document/figure/DJI_0027_Processed_by_MF.png');
imwrite(lpimg, '../../Document/figure/DJI_0027_Processed_by_LP.png');