img = double(imread('viaduct_52.jpg'))/255;
alpha = 0.0002;
maxTrainingTimes = 1e5;
nameVector = {'Road', 'Grass', 'Ground'};
trainingAreaCoordinate = [250, 300, 270, 320; 550, 40, 570, 60; 320, 220, 340, 240];
% Road Area; Grass Area; Ground Area
% Up Left Corner Row Index, Up Left Corner Col Index, 
% Down Right Corner Row Index, Down Right Corner Col Index
imgsize = size(img);
trainingAreaCoordinateSize = size(trainingAreaCoordinate);
classNum = trainingAreaCoordinateSize(1);
pointsPerArea = zeros(1, classNum);
weight = [rand(3, classNum); zeros(1, classNum)];
weightPlot = zeros(4*classNum, maxTrainingTimes);
wrongNumsPlot = zeros(classNum, maxTrainingTimes);
trainingSet = cell(1, classNum);
negativeTrainingSet = cell(1, classNum);
for i = 1:classNum
    areaVector = trainingAreaCoordinate(i, :);
    pointsPerArea(i) = (areaVector(3) - areaVector(1) + 1)*(areaVector(4) - areaVector(2) + 1);
    trainingSet{i} = [reshape(img(areaVector(1):areaVector(3), areaVector(2):areaVector(4), :), [], 3), ones(pointsPerArea(i), 1)];
end
for i = 1:classNum
    negativeTrainingSetLength = sum(pointsPerArea) - pointsPerArea(i);
    currentNegativeTrainingSet = zeros(negativeTrainingSetLength, 4);
    startIndex = 1;
    for j = 1:classNum
        if j ~= i
            currentNegativeTrainingSet(startIndex:startIndex + pointsPerArea(j) - 1, :) = trainingSet{j};
            startIndex = startIndex + pointsPerArea(j);
        end
    end
    negativeTrainingSet{i} = currentNegativeTrainingSet;
end
for i = 1:maxTrainingTimes
    for j = 1:classNum
        currentMark = trainingSet{j}*weight(:, j);
        currentNegativeMark = negativeTrainingSet{j}*weight(:, j);
        [wrongIndex, wrongStatus] = find(currentMark < 0);
        [wrongNegativeIndex, wrongNegativeStatus] = find(currentNegativeMark > 0);
        wrongNumsPlot(j, i) = length(wrongIndex);
        weight(:, j) = weight(:, j) + (alpha*(sum(trainingSet{j}(wrongIndex, :)) - sum(negativeTrainingSet{j}(wrongNegativeIndex, :))))';
    end
    weightPlot(:, i) = reshape(weight, [], 1);
end

pointClassification = zeros(imgsize(1)*imgsize(2), 1);
imgVector = [reshape(img, [], 3), ones(imgsize(1)*imgsize(2), 1)];
imgMarks = imgVector*weight;
[maxMark, maxIndex] = max(imgMarks, [], 2);
markMatrix = reshape(imgMarks, imgsize(1), imgsize(2), 3);
imgClassification = reshape(maxIndex, imgsize(1), imgsize(2));
finalImageClassificationLogic = zeros(imgsize(1), imgsize(2), classNum);
for i = 1:classNum
    finalImageClassificationLogic(:, :, i) = (imgClassification == i & markMatrix(:, :, i) > 0);
end
%{
for i = 1:classNum
    subplot(1, classNum, i);
    imshow(finalImageClassificationLogic(:, :, i));
end
figure;
plot(1:maxTrainingTimes, weightPlot);
xlabel('Training Times');
ylabel('Weight');
title('The Value of Weight Matrix');
figure;
plot(1:maxTrainingTimes, wrongNumsPlot);
xlabel('Training Times');
ylabel('Points');
title('Wrong Classifing Points');
%}
figure;
for i = 1:classNum
    subplot(2, 2, i);
    imshow(finalImageClassificationLogic(:, :, i));
end
subplot(2, 2, 4);
plot(1:maxTrainingTimes, weightPlot);

for i = 1:classNum
    imwrite(finalImageClassificationLogic(:, :, i), sprintf('../../Document/figure/viaduct_52_%s_Logic.png', nameVector{i}));
    imwrite(finalImageClassificationLogic(:, :, i).*img, sprintf('../../Document/figure/viaduct_52_%s_Separated.png', nameVector{i}));
end
