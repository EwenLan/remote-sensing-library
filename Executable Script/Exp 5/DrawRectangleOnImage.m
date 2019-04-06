img = imread('viaduct_52.jpg');
rectangleCoordinate = [250, 300, 270, 320; 550, 40, 570, 60; 320, 220, 340, 240];
alpha = 0.15;
colorset = {[0 0.4470 0.7410], [0.8500 0.3250 0.0980],...
        [0.9290 0.6940 0.1250], [0.4940 0.1840 0.5560],...
        [0.4660 0.6740 0.1880], [0.3010 0.7450 0.9330],...
        [0.6350 0.0780 0.1840]};
[rectangleNum, a] = size(rectangleCoordinate);
for i = 1:rectangleNum
    rowPts = rectangleCoordinate(i, 3) - rectangleCoordinate(i, 1) + 1;
    colPts = rectangleCoordinate(i, 4) - rectangleCoordinate(i, 2) + 1;
    for j = 0:1
        img(rectangleCoordinate(i, 1) - j:rectangleCoordinate(i, 3) + j, rectangleCoordinate(i, 2) - j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), rowPts + j*2, 1);
        img(rectangleCoordinate(i, 1) - j:rectangleCoordinate(i, 3) + j, rectangleCoordinate(i, 4) + j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), rowPts + j*2, 1);
        img(rectangleCoordinate(i, 1) - j, rectangleCoordinate(i, 2) - j:rectangleCoordinate(i, 4) + j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), colPts + j*2, 1);
        img(rectangleCoordinate(i, 3) + j, rectangleCoordinate(i, 2) - j:rectangleCoordinate(i, 4) + j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), colPts + j*2, 1);
    end
    img(rectangleCoordinate(i, 1) + 1:rectangleCoordinate(i, 3) - 1, rectangleCoordinate(i, 2) + 1:rectangleCoordinate(i, 4) - 1, :) = ...
        double(img(rectangleCoordinate(i, 1) + 1:rectangleCoordinate(i, 3) - 1, rectangleCoordinate(i, 2) + 1:rectangleCoordinate(i, 4) - 1, :))*(1 - alpha) + ...
        repmat(reshape(colorset{i}, 1, 1, 3), rowPts - 2, colPts - 2)*alpha*255;
end
imshow(img);
imwrite(img, '../../Document/figure/viaduct_52_Training_Set_Marker.png');