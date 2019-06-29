img1 = double(imread('san_1.bmp'));
img2 = double(imread('san_2.bmp'));

fusionDifferMat = FusionDifferDetection(img1, img2);
figure;
subplot(2, 2, 1);
imshow(fusionDifferMat == 0);
subplot(2, 2, 2);
imshow(fusionDifferMat == 1);
subplot(2, 2, 3);
imshow(fusionDifferMat == 2);
subplot(2, 2, 4);
imshow(fusionDifferMat == 3);