name = 'bridge_50.jpg';
args = [80, 6, 3];
figure;
img = imread(name);
detectedImg = WindowDetection(img, args(1), args(2), args(3));
subplot(1, 2, 1);
imshow(detectedImg);
subplot(1, 2, 2);
imshow(img);
imwrite(detectedImg, '../../Image Library/bridge_50_detection.png');
