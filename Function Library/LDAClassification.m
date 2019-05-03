function w = LDAClassification(positiveSamplesCell, negativeSamplesCell)
    alpha = 2e-4;
    maxTrainingTimes = 1e5;
    classNum = length(positiveSamplesCell);
    dims = size(positiveSamplesCell{1}, 2) - 1;
    w = [randn(dims, classNum); zeros(1, classNum)];
    for i = 1:maxTrainingTimes
        for j = 1:classNum
            currentPositiveMark = positiveSamplesCell{j} * w(:, j);
            currentNegativeMark = negativeSamplesCell{j} * w(:, j);
            [wrongPositiveIndex, ~] = find(currentPositiveMark < 0);
            [wrongNegativeIndex, ~] = find(currentNegativeMark > 0);
            w(:, j) = w(:, j) + (alpha * (sum(positiveSamplesCell{j}(wrongPositiveIndex, :)) - sum(negativeSamplesCell{j}(wrongNegativeIndex, :))))';
        end
    end
end