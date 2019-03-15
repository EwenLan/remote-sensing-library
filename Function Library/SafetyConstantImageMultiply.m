function newimg = SafetyConstantImageMultiply(img, mask, ratio)
    imgsize = size(img);
    imgsizesize = length(imgsize);
    newimg = zeros(imgsize, 'uint8');
    tmpimg = double(img);
    if imgsizesize == 2
        tmp1img = tmpimg.*mask*ratio;
        tmp2img = tmpimg.*(1 - mask);
        newimg = AutoGrayScale(tmp1img + tmp2img);
    else
        if imgsizesize == 3
            tmp1img = zeros(imgsize);
            tmp2img = zeros(imgsize);
            for i = 1:imgsize(3)
                %newimg(:,:,i) = SafetyConstantImageMultiply(img(:,:,i), mask, ratio);
                tmp1img(:,:,i) = tmpimg(:,:,i).*mask*ratio;
                tmp2img(:,:,i) = tmpimg(:,:,i).*(1 - mask);
            end
            newimg = AutoGrayScale(tmp1img + tmp2img);
        end
    end
end