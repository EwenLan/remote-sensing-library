function logicMap = LDAClassificationLogicMap(img, linearVector)
    imgsize = size(img);
    imgVector = [reshape(double(img) / 255, [], 3), ones(imgsize(1) * imgsize(2), 1)];
    if size(linearVector, 1) == 1
        linearVector = linearVector';
    end
    judgeMap = reshape(imgVector * linearVector, imgsize(1), imgsize(2));
    logicMap = judgeMap > 0;
end