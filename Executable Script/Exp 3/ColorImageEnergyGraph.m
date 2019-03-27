img = imread('DJI_0027_Compressed.png');
power = [1, 1, 1];
power = power/sum(power);
imgsize = size(img);
newimg = zeros(imgsize(1:2), 'uint8');
for i = 1:imgsize(3)
    newimg = newimg + power(i)*img(:,:,i);
end
imshow(newimg);
imwrite(newimg, '../../Document/figure/DJI_0027_Energy.png');