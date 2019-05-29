dataSetNames = {'Forest', 'Commercial'};
cuttedImageSize = [60, 60, 3];
classNum = length(dataSetNames);
dataSetFileNums = zeros(1, classNum);
for i = 1:classNum
    currentDataName = dataSetNames{i};
    currentDataPath = sprintf('../../Image Library/Exp 9/%s/*.jpg', currentDataName);
    currentDataFileList = dir(currentDataPath);
    dataSetFileNums(i) = length(currentDataFileList);
end
inputFileNums = min(dataSetFileNums);
rawData = zeros(classNum*inputFileNums, prod(cuttedImageSize), 'single');
for i = 1:classNum
    currentDataName = dataSetNames{i};
    currentDataPath = sprintf('../../Image Library/Exp 9/%s/*.jpg', currentDataName);
    currentDataFileList = dir(currentDataPath);
    for j = 1:inputFileNums
        img = single(imread(sprintf('../../Image Library/Exp 9/%s/%s', currentDataName, currentDataFileList(j).name)));
    end
end