function [pcaWeight, pcaEigVal] = PrincipalComponentAnalysis(samples, threshold)
    [~, dims] = size(samples);
    covMat = cov(samples);
    [eigVec, eigVal] = eig(covMat);
    preSortMat = [eigVec.', diag(eigVal)];
    sortedMat = sortrows(preSortMat, -(dims + 1));
    eigValSum = sum(sortedMat(:, dims + 1));
    cumSumEigVal = cumsum(sortedMat(:, dims + 1));
    a = find(cumSumEigVal >= threshold*eigValSum);
    projNum = a(1);
    pcaWeight = sortedMat(1:projNum, 1:dims).';
    pcaEigVal = sortedMat(1:projNum, dims + 1).';
end