img = imread('DJI_0027.png');
power = [1, 2, 1];
power = power/sum(power);
imgsize = size(img);
newimg = zeros(imgsize(1:2), 'uint8');
for i = 1:imgsize(3)
    newimg = newimg + power(i)*img(:,:,i);
end
imshow(newimg);