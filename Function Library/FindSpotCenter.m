function sum = FindSpotCenter(detectedImg, x, y, imgsize)
    sum = zeros(1, 3);
    if x > 0 && x <= imgsize.mat(1) && y > 0 && y <= imgsize.mat(2) && (detectedImg.mat(x, y) ~= 0)
        sum = sum + [x, y, 1];
        sum = sum + FindSpotCenter(detectedImg, x - 1, y, imgsize);
        sum = sum + FindSpotCenter(detectedImg, x + 1, y, imgsize);
        sum = sum + FindSpotCenter(detectedImg, x, y - 1, imgsize);
        sum = sum + FindSpotCenter(detectedImg, x, y + 1, imgsize);
        sum = sum + FindSpotCenter(detectedImg, x - 1, y - 1, imgsize);
        sum = sum + FindSpotCenter(detectedImg, x + 1, y - 1, imgsize);
        sum = sum + FindSpotCenter(detectedImg, x + 1, y - 1, imgsize);
        sum = sum + FindSpotCenter(detectedImg, x + 1, y + 1, imgsize);
    end
end