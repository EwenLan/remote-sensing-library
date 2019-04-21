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
trainingSet = cell(1, classNum);
negativeTrainingSet = cell(1, classNum);
for i = 1:classNum
    areaVector = trainingAreaCoordinate(i, :);
    pointsPerArea(i) = (areaVector(3) - areaVector(1) + 1)*(areaVector(4) - areaVector(2) + 1);
    trainingSet{i} = reshape(img(areaVector(1):areaVector(3), areaVector(2):areaVector(4), :), [], 3);
end
for i = 1:classNum
    negativeTrainingSetLength = sum(pointsPerArea) - pointsPerArea(i);
    currentNegativeTrainingSet = zeros(negativeTrainingSetLength, 3);
    startIndex = 1;
    for j = 1:classNum
        if j ~= i
            currentNegativeTrainingSet(startIndex:startIndex + pointsPerArea(j) - 1, :) = trainingSet{j};
            startIndex = startIndex + pointsPerArea(j);
        end
    end
    negativeTrainingSet{i} = currentNegativeTrainingSet;
end
RoadW = -TrainingLDAWeightMatrix(trainingSet{1}, negativeTrainingSet{1});
RoadB = 0;
for i = 1:1e5
    positiveMark = RoadW * trainingSet{1}' + RoadB;
    negativeMark = RoadW * negativeTrainingSet{1}' + RoadB;
    deltaB = 1e-5 * (sum(positiveMark < 0) - sum(negativeMark > 0));
    RoadB = RoadB + deltaB;
end
RoadLogic = reshape((RoadW * reshape(img, [], 3)' + RoadB) > 0, imgsize(1), imgsize(2));
imshow(RoadLogic);