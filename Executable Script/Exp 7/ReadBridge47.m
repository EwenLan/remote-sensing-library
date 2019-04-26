name = 'bridge_47.jpg';
args = [44, 6, 10];
figure;
img = imread(name);
detectedImg = WindowDetection(img, args(1), args(2), args(3));
subplot(1, 2, 1);
imshow(detectedImg);
subplot(1, 2, 2);
imshow(img);
