function newimg = GammaTransform(img, c, b)
    imgsize = size(img);
    img = double(img);
    newimg = zeros(imgsize, 'uint8');
    imgsizesize = length(imgsize);
    if imgsizesize == 2
        tmpimg = round(c.*img.^b.*255^(1 - b));
        if max(max(tmpimg)) > 255
            warning('The maximum value in caculation result exceed 255. It will leads to overflow.');
        end
        if min(min(tmpimg)) < 0
            warning('The minimum value in caculation result is less than 0. It will leads to overflow.');
        end
        newimg = uint8(tmpimg);
    else
        if imgsizesize == 3
            for i = 1:imgsize(3)
                newimg(:,:,i) = GammaTransform(img(:,:,i), c, b);
            end
        end
    end
end