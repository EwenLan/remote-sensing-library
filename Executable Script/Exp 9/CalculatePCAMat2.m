load('RawDataMat2.mat');
[pcaWeight, pcaEigVal] = PrincipalComponentAnalysis(rawData, 0.9);
save('PCA2.mat', 'pcaWeight', 'pcaEigVal');
featureData = rawData*single(pcaWeight);
save('featureData2.mat', 'classNum', 'dataSetNames', 'cuttedImageSize', 'cuttedRowNums', 'cuttedColNums', 'cuttedImageNums', 'inputFileNums', 'featureData');