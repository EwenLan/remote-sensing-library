img = imread('airport_44.jpg');
imgsize = size(img);
normalizedImg = double(img) / 255;
samplesNum = 3000;
classifierNum = 3;
rectangleCoordinate = [100, 80, 160, 160; 274, 105, 339, 187]; %; 533, 148, 593, 242];
figure;
imgWithRectangle = DrawRectangle(img, rectangleCoordinate);
imshow(imgWithRectangle);
classNum = size(rectangleCoordinate, 1);
positiveTrainingSet = cell(1, classNum);
negativeTrainingSet = cell(1, classNum);
pointsInArea = zeros(1, classNum);
for i = 1:classNum
    areaVector = rectangleCoordinate(i, :);
    pointsInArea(i) = (areaVector(3) - areaVector(1) + 1) * (areaVector(4) - areaVector(2) + 1);
    positiveTrainingSet{i} = [reshape(normalizedImg(areaVector(1):areaVector(3), areaVector(2):areaVector(4), :), [], 3), ones(pointsInArea(i), 1)];
end
for i = 1:classNum
    negativeTrainingSetLength = sum(pointsInArea) - pointsInArea(i);
    currentNegativeTrainingSet = zeros(negativeTrainingSetLength, 4);
    startIndex = 1;
    for j = 1:classNum
        if j ~= i
            currentNegativeTrainingSet(startIndex:startIndex + pointsInArea(j) - 1, :) = positiveTrainingSet{j};
            startIndex = startIndex + pointsInArea(j);
        end
    end
    negativeTrainingSet{i} = currentNegativeTrainingSet;
end

multiClassifierPositiveTrainingSet = cell(classifierNum, classNum);
multiClassifierNegativeTrainingSet = cell(classifierNum, classNum);
multiClassifierW = cell(1, classifierNum);
multiClassifierLogicMap = cell(classNum, classifierNum);
for i = 1:classifierNum
    for j = 1:classNum
        positiveSamplesNum = size(positiveTrainingSet{j}, 1);
        negativeSamplesNum = size(negativeTrainingSet{j}, 1);
        multiClassifierPositiveTrainingSet{i, j} = positiveTrainingSet{j}(randsample(1:positiveSamplesNum, samplesNum), :);
        multiClassifierNegativeTrainingSet{i, j} = negativeTrainingSet{j}(randsample(1:negativeSamplesNum, samplesNum), :);
    end
    p = multiClassifierPositiveTrainingSet(i, :);
    n = multiClassifierNegativeTrainingSet(i, :);
    multiClassifierW{i} = LDAClassification(p, n);
    for j = 1:classNum
        multiClassifierLogicMap{j, i} = LDAClassificationLogicMap(img, multiClassifierW{i}(:, j));
    end
end

votedClassificationLogicMap = cell(1, classNum);
votingThreshold = floor(classifierNum / 2) + 1;
for i = 1:classNum
    mapSum = zeros(imgsize(1:2));
    for j = 1:classifierNum
        mapSum = mapSum + multiClassifierLogicMap{i, j};
    end
    votedClassificationLogicMap{i} = mapSum >= votingThreshold;
end
figure;
for i = 1:classNum
    subplot(1, classNum, i);
    imshow(votedClassificationLogicMap{i});
end

figure;
for i = 1:classifierNum
    for j = 1:classNum
        subplot(classNum, classifierNum, (j - 1)*classifierNum + i);
        imshow(multiClassifierLogicMap{j, i});
    end
end