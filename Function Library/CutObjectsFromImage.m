function imgs = CutObjectsFromImage(img, rectangleCoordinates)
    rectNum = size(rectangleCoordinates, 1);
    imgs = cell(1, rectNum);
    dims = length(size(img));
    if dims == 3
        for i = 1:rectNum
            imgs{i} = img(rectangleCoordinates(i, 1):rectangleCoordinates(i, 3), ...
                rectangleCoordinates(i, 2):rectangleCoordinates(i, 4), :);
        end
    else
        if dims == 2
            for i = 1:rectNum
            imgs{i} = img(rectangleCoordinates(i, 1):rectangleCoordinates(i, 3), ...
                rectangleCoordinates(i, 2):rectangleCoordinates(i, 4));
            end
        end
    end
end