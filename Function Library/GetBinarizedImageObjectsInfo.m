function [objsInfo, labeledImg] = GetBinarizedImageObjectsInfo(binarizedImg)
    [labeledImg, objsNum] = bwlabeln(binarizedImg, 4);
    objsInfo = zeros(objsNum, 10);
    % |  1. Lable |  2. Objects Area |  3. Objects Center Row |  4. Objects Center Col |
    % |  5. Semi-Major Axis Vector X |  6. Semi-Major Axis Vector Y |
    % |  7. Semi-Minor Axis Vector X |  8. Semi-Minor Axis Vector Y |
    % |  9. Semi-Major Axis| 10. Semi-Minor Axis|
    for i = 1:objsNum
        objsInfo(i, 1) = i;
        objsInfo(i, 2) = sum(sum(labeledImg == i));
        [objPtsX, objPtsY] = find(labeledImg == i);
        objPtsCoord = [objPtsX, objPtsY];
        objsInfo(i, 3:4) = mean(objPtsCoord, 1);
        
        if size(objPtsCoord, 1) > 1
            covMat = cov(objPtsCoord);
        else
            covMat = cov([objPtsCoord; objPtsCoord]);
        end
        [eigVec, eigVal] = eig(covMat);
        preSortMat = [eigVec.', diag(eigVal)];
        sortedMat = sortrows(preSortMat, -3);
        objsInfo(i, 5:6) = sortedMat(1, 1:2)/norm(sortedMat(1, 1:2));
        objsInfo(i, 7:8) = sortedMat(2, 1:2)/norm(sortedMat(2, 1:2));
        
        projPts = objPtsCoord*[objsInfo(i, 5:6); objsInfo(i, 7:8)].';
        objsInfo(i, 9) = (max(projPts(:, 1) - min(projPts(:, 1))))/2;
        objsInfo(i, 10) = (max(projPts(:, 2) - min(projPts(:, 2))))/2;
    end
end