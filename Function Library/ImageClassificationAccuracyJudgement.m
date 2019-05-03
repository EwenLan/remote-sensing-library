function accuracy = ImageClassificationAccuracyJudgement(referenceLogicMap, sourceLogicMap)
    imgsize = size(referenceLogicMap);
    accuracy = 1 - sum(abs(double(sourceLogicMap) - double(referenceLogicMap)), 'all')/(imgsize(1)*imgsize(2));
end