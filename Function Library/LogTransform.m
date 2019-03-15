function newimg = LogTransform(img, c)
    imgsize = size(img);
    imgsizesize = length(imgsize);
    newimg = zeros(imgsize, 'uint8');
    if imgsizesize == 2
        img = double(img)/255;
        tmpimg = round(255*log(1 + c*img)/log(c + 1));
        if max(max(tmpimg)) > 255
            warning('The maximum value in caculation result exceed 255. It will leads to overflow.');
        end
        if min(min(tmpimg)) < 0
            warning('The minimum value in caculation result is less than 0. It will leads to overflow.');
        end
        newimg = uint8(tmpimg);
    else
        if imgsizesize == 3
            parfor i = 1:imgsize(3)
                newimg(:,:,i) = LogTransform(img(:,:,i), c);
            end
        end
    end
end