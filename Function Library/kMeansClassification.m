function classificaiton = kMeansClassification(samples, kNum)
    sampleNum = size(samples, 1);
    classificaiton = zeros(sampleNum, 1);
    dims = size(samples, 2);
    kCenters = randn(kNum, dims);
    lastKCenters = zeros(kNum, dims);
    maxTrainingTimes = 20;
    trainedTimes = 1;
    distanceMat = zeros(sampleNum, kNum);
    while ~isequal(kCenters, lastKCenters) && trainedTimes <= maxTrainingTimes
        for i = 1:kNum
            distanceMat(:, i) = vecnorm(samples - kCenters(i, :), 2, 2);
        end
        [~, classificaiton] = min(distanceMat, [], 2);
        newKCenters = zeros(kNum, dims);
        for i = 1:kNum
            newKCenters(i, :) = mean(samples(classificaiton == i, :), 1);
        end
        lastKCenters = kCenters;
        kCenters = newKCenters;
        trainedTimes = trainedTimes + 1;
    end
end