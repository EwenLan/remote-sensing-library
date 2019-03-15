function newimg = ImageDiffer_Minus(img1, img2)
    imgsize = size(img1);
    imgsizesize = length(imgsize);
    img2size = size(img2);
    newimg = zeros(imgsize, 'uint8');
    if imgsize ~= img2size
        error('The size of two images must be equal.');
    end
    if imgsizesize == 2
        ratio1 = double(img1) ./ (double(img2) + eps);
        ratio2 = double(img2) ./ (double(img1) + eps);
        ratio = zeros([imgsize, 2]);
        ratio(:,:,1) = ratio1;
        ratio(:,:,2) = ratio2;
        newimg = uint8((1 - min(ratio, [], 3))*255);
    else
        if imgsizesize == 3
            for i = 1:imgsize(3)
                newimg(:,:,i) = ImageDiffer_Minus(img1(:,:,i), img2(:,:,i));
            end
        end
    end
end