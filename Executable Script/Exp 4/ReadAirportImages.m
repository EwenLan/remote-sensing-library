img = imread('airport_44.jpg');
imgsize = size(img);
%imshow(img);

imgVecs = double(reshape(img, [], 3))/255;
imgVecsSize = size(imgVecs);
vecDims = imgVecsSize(2);
kNum = 2;
kCenter = rand(kNum, vecDims);
trainingTimes = 20;
colorset = {[0 0.4470 0.7410], [0.8500 0.3250 0.0980],...
    [0.9290 0.6940 0.1250], [0.4940 0.1840 0.5560],...
    [0.4660 0.6740 0.1880], [0.3010 0.7450 0.9330],...
    [0.6350 0.0780 0.1840]};
% fmat = moviein(trainingTimes);

for i = 1:trainingTimes
    diffVecs = zeros([size(imgVecs), kNum]);
    for j = 1:kNum
        diffVecs(:,:,j) = imgVecs - kCenter(j,:);
    end
    imgVecNorm = zeros(imgVecsSize(1), kNum);
    for j = 1:kNum
        imgVecNorm(:,j) = vecnorm(diffVecs(:,:,j), 2, 2);
    end
    [minValue, minIndex] = min(imgVecNorm, [], 2);
    newkCenter = zeros([kNum, vecDims]);
    
%     kMeansClusteringPlot(imgVecs, minIndex, kCenter, kNum);
%     fmat(:, i) = getframe;
    
    for j = 1:kNum
        newkCenter(j,:) = mean(imgVecs(minIndex == j,:));
    end
    kCenter = newkCenter;
    
%     classifiedImgArea = reshape(minIndex, imgsize(1:2));
%     imshow(classifiedImgArea == 1);
%     fmat(:,i) = getframe;
end

classifiedImgArea = reshape(minIndex, imgsize(1:2));
for i = 1:kNum
    figure;
    subplot(1, 2, 1);
    imshow(classifiedImgArea == i);
    subplot(1, 2, 2);
    simg = img.*uint8(classifiedImgArea == i);
    imshow(simg);
end
% figure;
% movie(fmat, 100, 10);

kMeansClusteringPlot(imgVecs, minIndex, kCenter, kNum);