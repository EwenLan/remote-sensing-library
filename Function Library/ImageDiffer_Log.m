function newimg = ImageDiffer_Log(img1, img2)
    imgsize = size(img1);
    imgsizesize = length(imgsize);
    img2size = size(img2);
    newimg = zeros(imgsize);
    if imgsize ~= img2size
        error('The size of two images must be equal.');
    end
    if imgsizesize == 2
        tmpimg = abs(log(double(img2)/255 + eps) - log(double(img1)/255 + eps));
        newimg = tmpimg;
    else
        if imgsizesize == 3
            for i = 1:imgsize(3)
                newimg(:,:,i) = ImageDiffer_Minus(img1(:,:,i), img2(:,:,i));
            end
        end
    end
end