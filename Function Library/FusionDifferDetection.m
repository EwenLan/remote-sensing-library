function newimg = FusionDifferDetection(img1, img2)
    img1size = size(img1);
    img2size = size(img2);
    channels = length(img1size);
    newimg = zeros(img1size, 'double');
    if channels > 2
        error('Images have multi-channels.');
    end
    if img1size ~= img2size
        error('Image 1 and Image 2 have different size.');
    end
    img1 = double(img1);
    img2 = double(img2);
    img1sum = sum(sum(img1));
    img2sum = sum(sum(img2));
    if img1sum < img2sum
        mu_a_img = img2;
        mu_b_img = img1;
    else
        mu_a_img = img1;
        mu_b_img = img2;
    end
    mu_a = ImageMeanFilter(mu_a_img, 2);
    mu_b = ImageMeanFilter(mu_b_img, 2);
    Xd = log(mu_a + 1) - log(mu_b + 1);
    Xd = Xd/(max(max(Xd)) - min(min(Xd)));
    classifiedImg = FuzzyClustering(Xd, 4);
    newimg = classifiedImg;
end