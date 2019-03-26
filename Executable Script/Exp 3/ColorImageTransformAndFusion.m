img = imread('DJI_0027_Compressed.png'.png');
imgsize = size(img);
newimg = zeros(imgsize, 'uint8');
noise = randn(imgsize(1:2))*32;

newimg(:,:,1) = img(:,:,1) + uint8(noise);
newimg(:,:,2) = LogTransform(img(:,:,2), 0.2);
newimg(:,:,3) = ReverseTransform(img(:,:,3));

imshow(newimg);