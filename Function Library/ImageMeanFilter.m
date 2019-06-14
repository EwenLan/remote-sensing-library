function newimg = ImageMeanFilter(img, mask_radius)
    imgsize = size(img);
    imgsizesize = length(imgsize);
    tmp_img = 0;
    if imgsizesize == 2
        padding_size = imgsize + [2, 2]*(mask_radius - 1);
        padding_img = ones(padding_size)*255;
        padding_img(mask_radius:imgsize(1)+mask_radius-1, mask_radius:imgsize(2)+mask_radius-1) = img;
        tmp_img = zeros(imgsize);
        for i = 1:imgsize(1)
            for j = 1:imgsize(2)
                tmp_img(i, j) = mean(mean(padding_img(i:i+(mask_radius - 1)*2, j:j+(mask_radius - 1)*2)));
            end
        end
    end
    if imgsizesize == 3
        tmp_img = uint8(zeros(imgsize));
        parfor i = 1:imgsize(3)
            tmp_img(:,:,i) = ImageMeanFilter(img(:,:,i), mask_radius);
        end
    end
    newimg = tmp_img;
end