function classificationMat = FuzzyClustering(img, centerNum)
    imgsize = size(img);
    imgsizesize = length(imgsize);
    classificationMat = zeros(imgsize(1:2));
    if imgsizesize == 2
        dims = 1;
    else
        if imgsizesize == 3
            dims = imgsize(3);
        else
            error('Unsupported matrix dimensions');
        end
    end
    img = double(img);
    maxTrainingTimes = 1e2;
    m = 2;
    imgVectorRows = imgsize(1)*imgsize(2);
    centerVector = randn(centerNum, dims);
    imgVector = reshape(img, imgVectorRows, dims);
    Umat = zeros(imgVectorRows, centerNum);
    for i = 1:70
        fprintf(' ');
    end
    for i = 1:maxTrainingTimes
        distanceMat = zeros(imgVectorRows, centerNum);
        for j = 1:centerNum
            distance = vecnorm(imgVector - centerVector(j, :), 2, 2);
            distanceMat(:, j) = distance;
        end
%         Umat = distanceMat./sum((distanceMat).^(-1/(m - 1)), 1);
        for j = 1:centerNum
            for k = 1:imgVectorRows
%                 sumVal = sum((distanceMat(k, j)./distanceMat(k, :)).^(-1/(m - 1)));
%                 Umat(j, k) = sumVal;
                Umat(k, j) = 1/(sum((distanceMat(k, j)./distanceMat(k, :)).^(2/(m - 1))));
            end
        end
        deltaCenterVector = (Umat.^m.*imgVector)./(sum(Umat, 2));
        centerVector = deltaCenterVector;
        ProgressBar(i/maxTrainingTimes);
    end
    [~, minInd] = min(distanceMat, [], 2);
    classificationMat = reshape(minInd - 1, imgsize(1), imgsize(2));
end