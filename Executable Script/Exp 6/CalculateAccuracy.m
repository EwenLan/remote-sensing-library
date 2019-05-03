classifierClassAccuracy = zeros(classifierNum, classNum);
classifierAllAccuracy = zeros(1, classifierNum);
classifierLabel = cell(1, classifierNum);
classLabel = cell(1, classNum);
samplePoints = sum(double(cell2mat(votedClassificationLogicMap)), 'all');
for i = 1:classifierNum
    classifierLabel{i} = sprintf('Classifier %d', i);
    for j = 1:classNum
        classifierClassAccuracy(i, j) = sum(double(multiClassifierLogicMap{j, i}.*votedClassificationLogicMap{j}), 'all')/sum(double(votedClassificationLogicMap{j}), 'all');
    end
    classifierAllAccuracy(i) = sum(double(cell2mat(multiClassifierLogicMap(:, i)).*cell2mat(votedClassificationLogicMap')), 'all')/samplePoints;
end
for i = 1:classNum
    classLabel{i} = sprintf('Class %d', i);
end
disp(classLabel);
disp(classifierClassAccuracy);
disp(classifierLabel);
disp(classifierAllAccuracy);
disp('Classifier Mean Accuracy');
disp(mean(classifierClassAccuracy, 2));
