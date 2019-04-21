function w = TrainingLDAWeightMatrix(positiveSamples, negativeSamples)
    [positiveNum, ~] = size(positiveSamples);
    [negativeNum, ~] = size(negativeSamples);
    meanVectors = [mean(positiveSamples); mean(negativeSamples)];
    
    positiveSc = (positiveSamples - meanVectors(1, :))' * (positiveSamples - meanVectors(1, :)) / (positiveNum - 1);
    negativeSc = (negativeSamples - meanVectors(2, :))' * (negativeSamples - meanVectors(2, :)) / (negativeNum - 1);
    Sw = positiveSc * positiveNum + negativeSc * negativeNum;
    
    overallMean = mean([positiveSamples; negativeSamples]);
    Sb = positiveNum * (meanVectors(1, :) - overallMean)' * (meanVectors(1, :) - overallMean) + negativeNum * (meanVectors(2, :) - overallMean)' * (meanVectors(2, :) - overallMean);
    
    [eigVecs, ~] = eig(Sw \ Sb);
    w = eigVecs(:, 1)';
end