img = imread('DJI_0027_Compressed.png');
colormap = [0, 1];
mask = colormap(rgb2gray(imread('DJI_0027_Compressed_Mask.png'))/255 + 1);
grayimg = rgb2gray(img);
newimg = SafetyConstantImageMultiply(img, mask, 5);
imshow(newimg);
imwrite(newimg, '../../Document/figure/DJI_0027_Interest.png');