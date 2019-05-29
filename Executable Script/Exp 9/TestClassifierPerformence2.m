load('testData.mat');
accuracy = zeros(classNum);
trainingSetIndex = zeros(classNum*trainingSetSize, 1);
for i = 1:classNum
    trainingSetIndex((i - 1)*trainingSetSize + 1:i*trainingSetSize) = i;
end
for i = 1:classNum
    currentTrainingDatasetBaseIndex = (i - 1)*trainingSetSize;
    currentTestDatasetBaseIndex = (i - 1)*testSetSize;
    for j = 1:testSetSize
        currentVector = testSet(currentTestDatasetBaseIndex + j, :);
        distanceMat = sortrows([vecnorm(trainingSet - currentVector, 2, 2), trainingSetIndex], 1);
        judgement = mode(distanceMat(1:19, 2));
        accuracy(i, judgement) = accuracy(i, judgement) + 1;
    end
end
accuracy = accuracy/testSetSize;
disp(accuracy);
% Forest, Commercial, Beach, Desert Classifying result
% Source Data || Judgement Result
%             || Forest | Commercial |  Beach | Desert
% ------------++--------+------------+--------+-------
% Forest      || 0.9193 |     0.0760 | 0.0033 | 0.0013
% Commercial  || 0.1200 |     0.8480 | 0.0273 | 0.0047
% Beach       || 0.0107 |     0.0107 | 0.9640 | 0.0147
% Desert      || 0.0007 |     0.0107 | 0.0013 | 0.9873