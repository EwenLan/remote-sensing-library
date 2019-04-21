imgs = cell(1, 3);
detectedImgs = cell(1, 3);
names = {'bridge_47.jpg', 'bridge_48.jpg', 'bridge_50.jpg'};
args = [40, 6, 8; 30, 8, 8; 56, 6, 8];
figure;
for i = 1:3
    imgs{i} = imread(names{i});
    detectedImgs{i} = WindowDetection(imgs{i}, args(i, 1), args(i, 2), args(i, 3));
    subplot(1, 3, i);
    imshow(detectedImgs{i});
end
