function imgWithRectangle = DrawRectangle(img, rectangleCoordinates)
    alpha = 0.15;
    thick = 2;
    imgsize = size(img);
    rectangleCoordinates(rectangleCoordinates < thick) = thick;
    rectangleCoordinates(rectangleCoordinates(:, 1) > imgsize(1) - thick + 1, 1) = imgsize(1) - thick + 1;
    rectangleCoordinates(rectangleCoordinates(:, 3) > imgsize(1) - thick + 1, 3) = imgsize(1) - thick + 1;
    rectangleCoordinates(rectangleCoordinates(:, 2) > imgsize(2) - thick + 1, 2) = imgsize(2) - thick + 1;
    rectangleCoordinates(rectangleCoordinates(:, 4) > imgsize(2) - thick + 1, 4) = imgsize(2) - thick + 1;
    imgWithRectangle = img;
    colorset = {[0 0.4470 0.7410], [0.8500 0.3250 0.0980],...
            [0.9290 0.6940 0.1250], [0.4940 0.1840 0.5560],...
            [0.4660 0.6740 0.1880], [0.3010 0.7450 0.9330],...
            [0.6350 0.0780 0.1840]};
    [rectangleNum, ~] = size(rectangleCoordinates);
    for i = 1:rectangleNum
        rowPts = rectangleCoordinates(i, 3) - rectangleCoordinates(i, 1) + 1;
        colPts = rectangleCoordinates(i, 4) - rectangleCoordinates(i, 2) + 1;
        for j = 0:thick - 1
            imgWithRectangle(rectangleCoordinates(i, 1) - j:rectangleCoordinates(i, 3) + j, rectangleCoordinates(i, 2) - j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), rowPts + j*2, 1);
            imgWithRectangle(rectangleCoordinates(i, 1) - j:rectangleCoordinates(i, 3) + j, rectangleCoordinates(i, 4) + j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), rowPts + j*2, 1);
            imgWithRectangle(rectangleCoordinates(i, 1) - j, rectangleCoordinates(i, 2) - j:rectangleCoordinates(i, 4) + j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), colPts + j*2, 1);
            imgWithRectangle(rectangleCoordinates(i, 3) + j, rectangleCoordinates(i, 2) - j:rectangleCoordinates(i, 4) + j, :) = repmat(reshape(colorset{i}*255, 1, [], 3), colPts + j*2, 1);
        end
        imgWithRectangle(rectangleCoordinates(i, 1) + 1:rectangleCoordinates(i, 3) - 1, rectangleCoordinates(i, 2) + 1:rectangleCoordinates(i, 4) - 1, :) = ...
            double(imgWithRectangle(rectangleCoordinates(i, 1) + 1:rectangleCoordinates(i, 3) - 1, rectangleCoordinates(i, 2) + 1:rectangleCoordinates(i, 4) - 1, :))*(1 - alpha) + ...
            repmat(reshape(colorset{i}, 1, 1, 3), rowPts - 2, colPts - 2)*alpha*255;
    end
end