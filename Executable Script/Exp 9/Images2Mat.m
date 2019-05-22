commercialImgsList = dir('../../Image Library/Exp 9/Commercial/*.png');
forestImgsList = dir('../../Image Library/Exp 9/Forest/*.png');
imgSize = 60*60*3;
listLength = min(length(commercialImgsList), length(forestImgsList));
trainingSetLength = round(listLength*alpha);
commercialMat = zeros(listLength, imgSize);
forestMat = zeros(listLength, imgSize);
for i = 1:listLength
    commercialImg = double(imread(['../../Image Library/Exp 9/Commercial/', commercialImgsList(i).name]))/255;
    forestImg = double(imread(['../../Image Library/Exp 9/Forest/', forestImgsList(i).name]))/255;
    commercialMat(i, :) = reshape(commercialImg, 1, []);
    forestMat(i, :) = reshape(forestImg, 1, []);
end
save('RawData.mat', 'commercialMat', 'forestMat');
