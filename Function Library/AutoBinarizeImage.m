function newimg = AutoBinarizeImage(img, powerThreshold)
    imgsize = size(img);
    imgsizesize = length(imgsize);
    newimg = zeros(imgsize, 'uint8');
    if imgsizesize == 2
        count = zeros([1, 256], 'int32');
        for i = 1:imgsize(1)
            for j = 1:imgsize(2)
                count(img(i, j) + 1) = count(img(i, j) + 1) + 1;
            end
        end
        cumcount = cumsum(count);
        pts = round(powerThreshold * imgsize(1) * imgsize(2));
        thres = 0;
        for i = 1:256
            if pts < cumcount(i)
                thres = i - 1;
                break
            end
        end
        newimg(img > thres) = 255;
    else
        if imgsizesize == 3
            parfor i = 1:imgsize(3)
                newimg(:,:,i) = AutoBinarizeImage(img(:,:,i), powerThreshold);
            end
        end
    end
end