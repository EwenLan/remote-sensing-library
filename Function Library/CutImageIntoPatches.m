function samples = CutImageIntoPatches(img, rows, cols)
    imgSize = size(img);
    imgSizeSize = length(imgSize);
    if imgSizeSize == 2
        cuttedRows = imgSize(1) - rows + 1;
        cuttedCols = imgSize(2) - cols + 1;
        samples = zeros(cuttedRows*cuttedCols, rows*cols);
        doubleImg = double(img);
        samplesIndex = 1;
        for i = 1:cuttedRows
            for j = 1:cuttedCols
                patch = doubleImg(i:i + rows - 1, j:j + cols - 1);
                samples(samplesIndex, :) = reshape(patch, 1, []);
                samplesIndex = samplesIndex + 1;
            end
        end
    else
        error('Unsupported Image Dimension.');
    end
end