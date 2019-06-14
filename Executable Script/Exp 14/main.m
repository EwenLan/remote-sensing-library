img1 = double(imread('san_1.bmp'));
img2 = double(imread('san_2.bmp'));

fusionDifferMat = FusionDifferDetection(img1, img2);
classification = FuzzyClustering(fusionDifferMat, 2);