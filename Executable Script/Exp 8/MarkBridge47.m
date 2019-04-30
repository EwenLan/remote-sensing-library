binarizedImg = imread('bridge_47_detection.png');
[labelImg, objsNum] = bwlabeln(binarizedImg, 4);
objsArea = zeros(1, objsNum);
objsCenter = zeros(2, objsNum);
objsSecondMoment = zeros(4, objsNum);
objsMajorAxisVector = zeros(2, objsNum);
objsSemiMajorAxis = zeros(1, objsNum);
objsSemiMinorAxis = zeros(1, objsNum);
objsEccentricity = zeros(1, objsNum);
for i = 1:objsNum
    objsArea(1, i) = sum(labelImg == i, 'all');
    [rows, cols] = find(labelImg == i);
    objsCenter(1, i) = mean(rows);
    objsCenter(2, i) = mean(cols);
    xvar = rows - objsCenter(1, i);
    yvar = cols - objsCenter(2, i);
    objsSecondMoment(1, i) = sum(xvar .^ 2) / objsArea(1, i);
    objsSecondMoment(2, i) = sum(xvar .* yvar) / objsArea(1, i);
    objsSecondMoment(3, i) = sum(yvar .* xvar) / objsArea(1, i);
    objsSecondMoment(4, i) = sum(yvar .^ 2) / objsArea(1, i);
    M = [objsSecondMoment(1, i), objsSecondMoment(2, i); ...
        objsSecondMoment(3, i), objsSecondMoment(4, i)];
    [V, D] = eig(M);
    majorAxis = (V(:, 1) / norm(V(:, 1)))';
    minorAxis = (V(:, 2) / norm(V(:, 2)))';
    objsMajorAxisVector(:, i) = majorAxis;
    objsProj = [rows, cols] * [majorAxis; minorAxis]';
    maxMajorAxis = max(objsProj(:, 1));
    minMajorAxis = min(objsProj(:, 1));
    maxMinorAxis = max(objsProj(:, 2));
    minMinorAxis = min(objsProj(:, 2));
    objsSemiMajorAxis(i) = (maxMajorAxis - minMajorAxis) / 2;
    objsSemiMinorAxis(i) = (maxMinorAxis - minMinorAxis) / 2;
%     objsEccentricity(i) = sqrt(1 - (objsSemiMinorAxis(i)) ^ 2 / (objsSemiMajorAxis(i)) ^ 2);
end
objsInfo = sortrows([1:objsNum; objsArea; objsCenter; objsSecondMoment; objsMajorAxisVector; objsSemiMajorAxis; objsSemiMinorAxis; objsEccentricity]', -2);
imshow(labelImg == objsInfo(1, 1));