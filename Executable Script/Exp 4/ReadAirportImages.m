img = imread('airport_44.jpg');
imgsize = size(img);

imgVecs = double(reshape(img, [], 3))/255;
imgVecsSize = size(imgVecs);
vecDims = imgVecsSize(2);
kNum = 2;
kCenter = rand(kNum, vecDims);
lastkCenter = rand(kNum, vecDims);
maxTrainingTimes = 20;
trainingTimes = 1;

gifFrame = {};
fig = figure;
while ~isequal(kCenter, lastkCenter) && trainingTimes <= maxTrainingTimes
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
    
    kMeansClusteringPlot(imgVecs, minIndex, kCenter, kNum);
    text(0.1, 0.9, 1, sprintf('Frame: %d', trainingTimes));
    drawnow;
    gifFrame{trainingTimes} = frame2im(getframe(fig));

    for j = 1:kNum
        newkCenter(j,:) = mean(imgVecs(minIndex == j,:));
    end
    lastkCenter = kCenter;
    kCenter = newkCenter;
    trainingTimes = trainingTimes + 1;
end
close(fig);

classifiedImgArea = reshape(minIndex, imgsize(1:2));
for i = 1:kNum
    figure;
    subplot(1, 2, 1);
    imshow(classifiedImgArea == i);
    subplot(1, 2, 2);
    simg = img.*uint8(classifiedImgArea == i);
    imshow(simg);
    imwrite(classifiedImgArea == i, sprintf('../../Document/figure/airport_44_Class_%02d_Logical.png', i));
    imwrite(simg, sprintf('../../Document/figure/airport_44_Class_%02d_Separated.png', i));
end

ExportGifAnimate(gifFrame, '../../Document/figure/airport_44_Clustering_Animation.gif');
ExportLatexAnimate(gifFrame, '../../Document/figure/airport_44_Clustering_Latex_Animate/frame');