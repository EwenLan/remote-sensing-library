binarizedImg = imread('bridge_50_detection.png') > 0;
img = imread('bridge_50.jpg');
preprocessedImg = imclose(binarizedImg, strel('disk', 3));
[objsInfo, labeledImg] = GetBinarizedImageObjectsInfo(preprocessedImg);
areaSortedObjsInfo = sortrows(objsInfo, -2);
aspectRatio = areaSortedObjsInfo(:, 9)./(areaSortedObjsInfo(:, 10) + eps);
objsNum = size(objsInfo, 1);
pickedObjs = areaSortedObjsInfo(areaSortedObjsInfo(:, 2) < 3000 & areaSortedObjsInfo(:, 2) > 1500 & aspectRatio(:) > 1 & aspectRatio(:) < 5, :);
pickedRectangle = zeros(size(pickedObjs, 1), 4);
for i = 1:size(pickedObjs, 1)
    radius = norm(pickedObjs(i, 9:10)) + 4;
    pickedRectangle(i, :) = round([pickedObjs(i, 3:4) - radius, pickedObjs(i, 3:4) + radius]);
end
imgWithRectangle = DrawRectangle(img, pickedRectangle(:, :));
imshow(imgWithRectangle);
imwrite(imgWithRectangle, '../../Document/figure/bridge_50_marked_ship.png');
objImgs = CutObjectsFromImage(img, pickedRectangle);
pickedObjNum = length(objImgs);
for i = 1:pickedObjNum
    imwrite(objImgs{i}, sprintf('../../Document/figure/bridge_50_cutted_object_%d.png', i));
end