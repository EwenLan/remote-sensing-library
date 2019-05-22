load('RawData.mat');
rawData = [commercialMat; forestMat];
[pcaWeight, pcaEigVal] = PrincipalComponentAnalysis(rawData, 0.9);
save('PCA.mat', 'pcaWeight', 'pcaEigVal');