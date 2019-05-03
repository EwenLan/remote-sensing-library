imwrite(imgWithRectangle, '../../Document/figure/airport_44_Ensemble_Learning_Training_Set.png');
for i = 1:classifierNum
    for j = 1:classNum
        imwrite(multiClassifierLogicMap{j, i}, sprintf('../../Document/figure/airport_44_Classifier_%d_Class_%d.png', i, j));
    end
end
for i = 1:classNum
    imwrite(votedClassificationLogicMap{i}, sprintf('../../Document/figure/airport_44_Class_%d.png', i));
end