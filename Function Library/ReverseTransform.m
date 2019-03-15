function newimg = ReverseTransform(img)
    imgsize = size(img);
    imgsizesize = length(imgsize);
    newimg = zeros(imgsize, 'uint8');
    if imgsizesize == 2
        newimg = 255 - img;
    else
        if imgsizesize == 3
            parfor i = 1:imgsize(3)
                newimg(:,:,i) = ReverseTransform(img(:,:,i));
            end
        end
    end
end