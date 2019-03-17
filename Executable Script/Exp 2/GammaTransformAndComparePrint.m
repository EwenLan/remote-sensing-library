img = imread('DJI_0027_Gray.png');
args = [1, 0.5, 2];
argc = [1, 1, 1];

figure;
imhist(img);
set(gca, 'FontSize', 16);
saveas(gcf, '../../Document/figure/DJI_0027_Histogram.eps');
close;

for i = 1:length(args)
    newimg = GammaTransform(img, 1, args(i));
    imwrite(newimg, sprintf('../../Document/figure/DJI_0027_Gamma_%d.png', args(i)*100));
    figure;
    PlotGammaTransformFunction(1, args(i));
    saveas(gcf, sprintf('../../Document/figure/DJI_0027_Gamma_%d_Graph.eps', args(i)*100));
    close;
end