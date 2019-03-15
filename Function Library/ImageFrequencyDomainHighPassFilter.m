function newimg = frequency_domain_high_pass_filter(img, radius_scale)
    imgsize = size(img);
    imgsizesize = length(imgsize);
    full_circle_radius = norm(imgsize(1:2))/2;
    low_pass_filter_radius = full_circle_radius*radius_scale;
    center_point = (imgsize(1:2) + 1)/2;
    mask = ones(imgsize(1:2));
    value_map = [1, 0];
    for i = 1:imgsize(1)
        if low_pass_filter_radius >= abs(i - center_point(1))
            half_chord_length = floor(sqrt(low_pass_filter_radius^2 - (i - center_point(1))^2));
            if half_chord_length > imgsize(2)/2
                half_chord_length = floor(imgsize(2)/2);
            end
            mask(i, ceil(center_point(2) - half_chord_length):floor(center_point(2) + half_chord_length)) = 2;
        end
    end
    mask = value_map(mask);
    imshow(mask, [0, 1]);
    if imgsizesize == 2
        IMG = fftshift(fft2(double(img)));
        IMG = IMG.*mask;
        newimg = uint8(real(ifft2(ifftshift(IMG))));
    end
    if imgsizesize == 3
        newimg = zeros(imgsize, 'uint8');
        for i = 1:imgsize(3)
            newimg(:,:,i) = uint8(real(ifft2(ifftshift(mask.*fftshift(fft2(double(img(:,:,i))))))));
        end
    end
end