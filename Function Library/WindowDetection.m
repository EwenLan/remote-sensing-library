function binarizedImage = WindowDetection(img, alertWindowRadius, paddingSize, normalDistributionThreshold)
    iif = @(c, x, y) c * x + (1 - c) * y;
    imgsize = size(img);
    binarizedImage = zeros(imgsize(1), imgsize(2), 'uint8');
    img = double(img) / 255;
    imgsizesize = length(imgsize);
    if imgsizesize == 3
        for i = 1:imgsize(1)
            for j = 1:imgsize(2)
                paddingMatrix = [reshape(img(iif(i - alertWindowRadius - paddingSize < 1, 1, i - alertWindowRadius - paddingSize): ...
                    iif(i - alertWindowRadius - 1 < 1, 0, i - alertWindowRadius - 1), ...
                    iif(j - alertWindowRadius - paddingSize < 1, 1, j - alertWindowRadius - paddingSize): ...
                    iif(j + alertWindowRadius + paddingSize > imgsize(2), imgsize(2), j + alertWindowRadius + paddingSize), :), [], 3); ...
                    reshape(img(iif(i + alertWindowRadius + 1 > imgsize(1), imgsize(1) + 1, i + alertWindowRadius + 1): ...
                    iif(i + alertWindowRadius + paddingSize > imgsize(1), imgsize(1), i + alertWindowRadius + paddingSize), ...
                    iif(j - alertWindowRadius - paddingSize < 1, 1, j - alertWindowRadius - paddingSize): ...
                    iif(j + alertWindowRadius + paddingSize > imgsize(2), imgsize(2), j + alertWindowRadius + paddingSize), :), [], 3); ...
                    reshape(img(iif(i - alertWindowRadius < 1, 1, i - alertWindowRadius): ...
                    iif(i + alertWindowRadius > imgsize(2), imgsize(2), i + alertWindowRadius), ...
                    iif(j - alertWindowRadius - paddingSize < 1, 1, j - alertWindowRadius - paddingSize): ...
                    iif(j - alertWindowRadius - 1 < 1, 0, j - alertWindowRadius - 1), :), [], 3); ...
                    reshape(img(iif(i - alertWindowRadius < 1, 1, i - alertWindowRadius): ...
                    iif(i + alertWindowRadius > imgsize(1), imgsize(1), i + alertWindowRadius), ...
                    iif(j + alertWindowRadius + 1 > imgsize(2), imgsize(2) + 1, j + alertWindowRadius + 1): ...
                    iif(j + alertWindowRadius + paddingSize > imgsize(2), imgsize(2), j + alertWindowRadius + paddingSize), :), [], 3)];
                mu = mean(paddingMatrix);
                sigma = std(paddingMatrix);
                aim = reshape(img(i, j, :), 1, 3);
                distance = norm((aim - mu) ./ sigma);
                if distance > normalDistributionThreshold
                    binarizedImage(i, j) = 255;
                end
            end
        end
    else
    end
end