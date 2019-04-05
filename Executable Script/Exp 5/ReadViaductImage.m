img = imread('viaduct_52.jpg');
trainingAreaCoordinate = [250, 300, 270, 320; 450, 150, 470, 170; 90, 160, 110, 180];
% Road Area; Grass Area; Ground Area
% Up Left Corner Row Index, Up Left Corner Col Index, 
% Down Right Corner Row Index, Down Right Corner Col Index
trainingAreaCoordinateSize = size(trainingAreaCoordinate);
classNum = trainingAreaCoordinateSize(1);
pointsPerArea = zeros(1, classNum);
trainingSet = cell(1, classNum);
for i = 1:classNum
    areaVector = trainingAreaCoordinate(i, :);
    pointsPerArea(i) = (areaVector(3) - areaVector(1) + 1)*(areaVector(4) - areaVector(2) + 1);
    trainingSet{i} = reshape(img(areaVector(1):areaVector(3), areaVector(2):areaVector(4)), [], 3);
end
