function newimg = AutoGrayScale(img)
    imgsize = size(img);
    imgsizesize = length(imgsize);
    newimg = zeros(imgsize, 'uint8');
    img = double(img);
    minval = 0;
    maxval = 1;
    if imgsizesize == 2
        minval = min(min(img));
        maxval = max(max(img)) - minval;
    else
        if imgsizesize == 3
           for i = 1:imgsize(3)
                %newimg(:,:,i) = AutoGrayScale(img(:,:,i));
                minval = min(min(min(img)));
                maxval = max(max(max(img))) - minval;
            end
        end
    end
    img = (img - minval)/maxval*255;
    newimg = uint8(img);
end