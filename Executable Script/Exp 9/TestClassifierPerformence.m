load('PCA.mat');
load('TestSet.mat');
load('TrainingSet.mat');
distanceOptions = 19;
forestTrainingSet = forestTrainingSet*pcaWeight;
commercialTrainingSet = commercialTrainingSet*pcaWeight;
forestTestSet = forestTestSet*pcaWeight;
commercialTestSet = commercialTestSet*pcaWeight;
testSetSize = size(commercialTestSet, 1);
trainingSetSize = size(commercialTrainingSet, 1);
dims = size(commercialTrainingSet, 2);
accuracy = zeros(2, 2);
%                       | Classifier Judgement  |
%                       | Right     | Wrong     |
% ---------|------------|-----------|-----------|
% Test Set | Commercial | 0.8591    | 0.1409    |
% Sources  | Forest     | 0.9667    | 0.0333    |
%% Commercial Test
CommercialTestResult = zeros(1, testSetSize);
for i = 1:testSetSize
    distanceToCommercial = [vecnorm((commercialTrainingSet - commercialTestSet(i, :))'); ones(1, trainingSetSize)];
    distanceToForest = [vecnorm((forestTrainingSet - commercialTestSet(i, :))'); zeros(1, trainingSetSize)];
    distance = sortrows([distanceToCommercial, distanceToForest]', 1);
    CommercialTestResult(i) = sum(distance(1:distanceOptions, 2)) > distanceOptions/2;
end
%% Forest Test
ForestTestResult = zeros(1, testSetSize);
for i = 1:testSetSize
    distanceToForest = [vecnorm((forestTrainingSet - forestTestSet(i, :))'); ones(1, trainingSetSize)];
    distanceToCommercial = [vecnorm((commercialTrainingSet - forestTestSet(i, :))'); zeros(1, trainingSetSize)];
    distance = sortrows([distanceToCommercial, distanceToForest]', 1);
    ForestTestResult(i) = sum(distance(1:distanceOptions, 2)) > distanceOptions/2;
end
accuracy(1, 1) = sum(CommercialTestResult == 1)/testSetSize;
accuracy(1, 2) = sum(CommercialTestResult == 0)/testSetSize;
accuracy(2, 1) = sum(ForestTestResult == 1)/testSetSize;
accuracy(2, 2) = sum(ForestTestResult == 0)/testSetSize;
disp(accuracy);