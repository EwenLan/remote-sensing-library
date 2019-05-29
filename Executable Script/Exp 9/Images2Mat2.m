dataSetNames = {'Forest', 'Commercial'};
cuttedImageSize = [60, 60, 3];
cuttedRowNums = 10;
cuttedColNums = 10;
cuttedImageNums = cuttedRowNums*cuttedColNums;
classNum = length(dataSetNames);
dataSetFileNums = zeros(1, classNum);
for i = 1:classNum
    currentDataName = dataSetNames{i};
    currentDataPath = sprintf('../../Image Library/Exp 9/%s/*.jpg', currentDataName);
    currentDataFileList = dir(currentDataPath);
    dataSetFileNums(i) = length(currentDataFileList);
end
inputFileNums = min(dataSetFileNums);
rawData = zeros(classNum*inputFileNums*cuttedImageNums, prod(cuttedImageSize), 'single');
for i = 1:classNum
    currentDataName = dataSetNames{i};
    currentDataPath = sprintf('../../Image Library/Exp 9/%s/*.jpg', currentDataName);
    currentDataFileList = dir(currentDataPath);
    for j = 1:inputFileNums
        img = single(imread(sprintf('../../Image Library/Exp 9/%s/%s', currentDataName, currentDataFileList(j).name)));
        for k = 1:cuttedRowNums
            for l = 1:cuttedColNums
                currentRawDataIndex = ((i - 1)*inputFileNums + (j - 1))*cuttedImageNums + (k - 1)*cuttedColNums + l;
                currentSubImage = reshape(single(img((k - 1)*cuttedImageSize(1) + 1:k*cuttedImageSize(1), (l - 1)*cuttedImageSize(2) + 1:l*cuttedImageSize(2), :)), 1, [])/255;
                rawData(currentRawDataIndex, :) = currentSubImage;
            end
        end
    end
end
save('RawDataMat2.mat', 'classNum', 'dataSetNames', 'cuttedImageSize', 'cuttedRowNums', 'cuttedColNums', 'cuttedImageNums', 'inputFileNums', 'rawData');