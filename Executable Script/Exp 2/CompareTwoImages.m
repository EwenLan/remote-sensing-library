img1 = imread('san_1.bmp');
img2 = imread('san_2.bmp');
destimg = imread('san_gt.bmp');
% fimg1 = ImageMeanFilter(img1, 3);
% fimg2 = ImageMeanFilter(img2, 3);
fimg1 = ImageFrequencyDomainLowPassFilter(img1, 0.4);
fimg2 = ImageFrequencyDomainLowPassFilter(img2, 0.4);

newimg2 = GammaTransform(fimg2, 1, 0.7);

diffimg = AutoBinarizeImage(fimg1 - newimg2, 0.9);
subplot(2, 2, 1);
image(img1);
subplot(2, 2, 2);
image(newimg2);
subplot(2, 2, 3);
imshow(diffimg);
subplot(2, 2, 4);
imshow(destimg);