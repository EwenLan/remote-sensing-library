load('featureData2.mat');
alpha = 0.7;
dataSetSize = cuttedImageNums*inputFileNums;
trainingSetSize = round(alpha*dataSetSize);
testSetSize = dataSetSize - trainingSetSize;
trainingSet = zeros(trainingSetSize*classNum, size(featureData, 2), 'single');
testSet = zeros(testSetSize*classNum, size(featureData, 2), 'single');
for i = 1:classNum
    currentDatasetBaseIndex = (i - 1)*dataSetSize;
    currentDatasetTrainingArea = [(i - 1)*trainingSetSize + 1, i*trainingSetSize];
    currentDatasetTestArea = [(i - 1)*testSetSize + 1, i*testSetSize];
    trainingIndex = randsample(1:dataSetSize, trainingSetSize);
    testIndex = find(~ismember(1:dataSetSize, trainingIndex));
    trainingIndex = trainingIndex + currentDatasetBaseIndex;
    testIndex = testIndex + currentDatasetBaseIndex;
    trainingSet(currentDatasetTrainingArea(1):currentDatasetTrainingArea(2), :) = ...
        featureData(trainingIndex, :);
    testSet(currentDatasetTestArea(1):currentDatasetTestArea(2), :) = ...
        featureData(testIndex, :);
end
save('testData.mat', 'classNum', 'trainingSetSize', 'testSetSize', 'trainingSet', 'testSet');