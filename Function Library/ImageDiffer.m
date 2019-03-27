function newimg = ImageDiffer(img1, img2, radiusScale)
    dimg1 = ImageDiffer_Minus(img1, img2);
    dimg2 = ImageDiffer_Log(img1, img2);
    imgsize = size(img1);
    fullCircleRadius = norm(imgsize(1:2))/2;
    freqBorder = fullCircleRadius*radiusScale;
    mask = zeros(imgsize(1:2));
    centerPoint = (imgsize(1:2) + 1)/2;
    for i = 1:imgsize(1)
        if freqBorder >= abs(i - centerPoint)
            halfChordLength = floor(sqrt(freqBorder^2 - (i - centerPoint(1))^2));
            if halfChordLength > imgsize(2)/2
                halfChordLength = floor(imgsize(2)/2);
            end
            mask(i, ceil(centerPoint(2) - halfChordLength):floor(centerPoint(2) + halfChordLength)) = 1;
        end
    end
    colorset = [1, 0];
    unmask = colorset(mask + 1);
    DIMG1 = fftshift(fft2(dimg1));
    DIMG2 = fftshift(fft2(dimg2));
    lowFreqDIMG1 = DIMG1.*mask;
    lowFreqDIMG2 = DIMG2.*mask;
    highFreqDIMG1 = DIMG1.*unmask;
    highFreqDIMG2 = DIMG2.*unmask;
    lowFreqDIMG = mean(cat(3, lowFreqDIMG1, lowFreqDIMG2), 3);
    highFreqDIMG = min(highFreqDIMG1, highFreqDIMG2);
    DIMG = lowFreqDIMG + highFreqDIMG;
    newimg = uint8(real(ifft2(ifftshift(DIMG)))*255);
end