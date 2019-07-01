img1 = double(imread('san_1.bmp'));
img2 = double(imread('san_2.bmp'));

fusionDifferMat = FusionDifferDetection(img1, img2);
uint8FusionDifferMat = AutoGrayScale(fusionDifferMat);
binarizedFusionDifferMat = AutoBinarizeImage(uint8FusionDifferMat, 0.94);
figure;
imshow(binarizedFusionDifferMat);
imwrite(binarizedFusionDifferMat, '../../Document/figure/FinalResult.png');