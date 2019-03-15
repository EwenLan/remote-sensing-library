img1 = double(histeq(imread('san_1.bmp')));
img2 = double(histeq(imread('san_2.bmp')));
% imgN = zeros([size(img1), 3], 'uint8');
% imgN(:,:,1) = img1;
% imgN(:,:,3) = img2;
% imgN(:,:,2) = ones(size(img1))*100;
imgN = img1 ./ img2;
imgM = img2 ./ img1;
newimgN = max(imgN, imgM);
newimgN = AutoGrayScale(newimgN);
sort
%imgN = uint8(imgN);
%imhist(img1);
imshow(newimgN, [0, 255]);