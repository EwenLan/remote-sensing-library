load RawData.mat;
alpha = 0.7;
setSize = size(commercialMat, 1);
trainingSetSize = round(0.7*setSize);
testSetSize = setSize - trainingSetSize;
commercialTrainingSetIndex = randsample(1:setSize, trainingSetSize);
forestTrainingSetIndex = randsample(1:setSize, trainingSetSize);
commercialTrainingSet = commercialMat(commercialTrainingSetIndex, :);
forestTrainingSet = forestMat(forestTrainingSetIndex, :);
commercialTestSet = commercialMat(~ismember(1:setSize, commercialTrainingSetIndex), :);
forestTestSet = forestMat(~ismember(1:setSize, forestTrainingSetIndex), :);
save('TrainingSet.mat', 'commercialTrainingSet', 'forestTrainingSet');
save('TestSet.mat', 'commercialTestSet', 'forestTestSet');