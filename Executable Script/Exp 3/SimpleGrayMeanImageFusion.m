img = imread('DJI_0027_Compressed.png');
colormap = [1, 2];
mask = colormap(double(rgb2gray(imread('mask.png')))/255 + 1);
imgsize = size(img);
newimg = ImageFusion([2, 1, 1], mask, img(:,:,1), img(:,:,2), img(:,:,3));
imshow(newimg);