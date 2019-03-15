img = imread('san_1.bmp');
args = [1, 0.5, 2];
argc = [1, 1, 1];
img1 = GammaTransform(img, argc(1), args(1));
img2 = GammaTransform(img, argc(2), args(2));
img3 = GammaTransform(img, argc(3), args(3));

subplot(2, 4, 1);
imshow(img);
title('Original Image');
subplot(2, 4, 2);
imhist(img);
title('Histogram of Image');

subplot(2, 4, 3);
imshow(img1);
title(sprintf('s = %.2f*r^{%.2f}', argc(1), args(1)));
subplot(2, 4, 4);
PlotGammaTransformFunction(1, args(1));
title(sprintf('s = %.2f*r^{%.2f}', argc(1), args(1)));

subplot(2, 4, 5);
imshow(img2);
title(sprintf('s = %.2f*r^{%.2f}', argc(2), args(2)));
subplot(2, 4, 6);
PlotGammaTransformFunction(1, args(2));
title(sprintf('s = %.2f*r^{%.2f}', argc(2), args(2)));

subplot(2, 4, 7);
imshow(img3);
title(sprintf('s = %.2f*r^{%.2f}', argc(3), args(3)));
subplot(2, 4, 8);
PlotGammaTransformFunction(1, args(3));
title(sprintf('s = %.2f*r^{%.2f}', argc(3), args(3)));