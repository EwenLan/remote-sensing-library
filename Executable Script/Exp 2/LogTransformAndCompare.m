img = imread('san_1.bmp');
args = [1, 10, 100];

img1 = LogTransform(img, args(1));
img2 = LogTransform(img, args(2));
img3 = LogTransform(img, args(3));

subplot(2, 4, 1);
imshow(img);
title('Original Image');
subplot(2, 4, 2);
imhist(img);
title('Histogram of Image');

subplot(2, 4, 3);
imshow(img1);
title(sprintf('s = %.2f*log(1 + r)', args(1)));
subplot(2, 4, 4);
PlotLogTransformFunction(args(1));
title(sprintf('s = %.2f*log(1 + r)', args(1)));

subplot(2, 4, 5);
imshow(img2);
title(sprintf('s = %.2f*log(1 + r)', args(2)));
subplot(2, 4, 6);
PlotLogTransformFunction(args(2));
title(sprintf('s = %.2f*log(1 + r)', args(2)));

subplot(2, 4, 7);
imshow(img3);
title(sprintf('s = %.2f*log(1 + r)', args(3)));
subplot(2, 4, 8);
PlotLogTransformFunction(args(3));
title(sprintf('s = %.2f*log(1 + r)', args(3)));