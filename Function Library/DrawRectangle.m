function imgWithRectangle = DrawRectangle(img, rectangleCoordinate)
    alpha = 0.15;
    imgWithRectangle = img;
    colorset = {[0 0.4470 0.7410], [0.8500 0.3250 0.0980],...
            [0.9290 0.6940 0.1250], [0.4940 0.1840 0.5560],...
            [0.4660 0.6740 0.1880], [0.3010 0.7450 0.9330],...
            [0.6350 0.0780 0.1840]};
    [rectangleNum, ~] = size(rectangleCoordinate);
    for i = 1:rectangleNum
        rowPts = rectangleCoordinate(i, 3) - rectangleCoordinate(i, 1) + 1;
        colPts = rectangleCoordinate(i, 4) - rectangleCoordinate(i, 2) + 1;
        for j = 0:1
            imgWithRectangle(rectangleCoordinate(i, 1) - j:rectangleCoordinate(i, 3) + j, rectangleCoordinate(i, 2) - j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), rowPts + j*2, 1);
            imgWithRectangle(rectangleCoordinate(i, 1) - j:rectangleCoordinate(i, 3) + j, rectangleCoordinate(i, 4) + j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), rowPts + j*2, 1);
            imgWithRectangle(rectangleCoordinate(i, 1) - j, rectangleCoordinate(i, 2) - j:rectangleCoordinate(i, 4) + j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), colPts + j*2, 1);
            imgWithRectangle(rectangleCoordinate(i, 3) + j, rectangleCoordinate(i, 2) - j:rectangleCoordinate(i, 4) + j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), colPts + j*2, 1);
        end
        imgWithRectangle(rectangleCoordinate(i, 1) + 1:rectangleCoordinate(i, 3) - 1, rectangleCoordinate(i, 2) + 1:rectangleCoordinate(i, 4) - 1, :) = ...
            double(imgWithRectangle(rectangleCoordinate(i, 1) + 1:rectangleCoordinate(i, 3) - 1, rectangleCoordinate(i, 2) + 1:rectangleCoordinate(i, 4) - 1, :))*(1 - alpha) + ...
            repmat(reshape(colorset{i}, 1, 1, 3), rowPts - 2, colPts - 2)*alpha*255;
    end
end