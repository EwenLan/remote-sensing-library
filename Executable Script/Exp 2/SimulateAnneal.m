img1 = imread('san_1.bmp');
img2 = imread('san_2.bmp');
destimg = imread('san_gt.bmp');
argsVector = [3, 1, 0.7, 0.9];
% argsVector Arguments Declaration:
% (1): san_1/san_2 Mean Filter Radius.
% (2): san_1 Gamma Transform b.
% (3): san_2 Gamma Transform b.
% (4): Differ Image Power Ratio. Lower: More white. Higher: Less white.
trainingTimes = 1000;
lastMark = inf;
tringArgsVector = argsVector;
for i = 1:trainingTimes
    fimg1 = ImageMeanFilter(img1, argsVector(1));
    fimg2 = ImageMeanFilter(img2, argsVector(1));
    gimg1 = GammaTransform(fimg1, argsVector(2));
    gimg2 = GammaTransform(fimg2, argsVector(3));
    differImg = gimg2 - gimg1;
    bdimg = AutoBinarizeImage(differImg, argsVector(4));
    % Judgement: Make the mark lower.
    mark = sum(sum(abs(bdimg - destimg)));
    if mark <= lastMark
        % Accept the new result.
    else
    end
end