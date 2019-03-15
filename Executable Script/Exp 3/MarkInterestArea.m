img = imread('DJI_0027.png');
colormap = [1, 0];
mask = colormap(rgb2gray(imread('mask.png'))/255 + 1);
grayimg = rgb2gray(img);
newimg = SafetyConstantImageMultiply(img, mask, 5);
imshow(newimg);