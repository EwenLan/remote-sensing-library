img1 = imread('san_1.bmp');
img2 = imread('san_2.bmp');
destimg = imread('san_gt.bmp');
% argsVector = [0.4502, 0.8854, 0.3632, 0.9560];
argsVector = [0.6, 0.6, 0.6, 0.6];
markVector = zeros(1, 10000);
top = 1;
% argsVector Arguments Declaration:
% (1): san_1/san_2 Low Pass Filter Radius.
% (2): san_1 Gamma Transform b.
% (3): san_2 Gamma Transform b.
% (4): Differ Image Power Ratio. Lower: More white. Higher: Less white.
limitTemp = 0.0002;
lastMark = 99999999;
tringArgsVector = argsVector;
dE = 0;
temp = 9999999;
alpha = 0.99;
trainingStep = 0.02;
trainingTimes = 0;
while temp > limitTemp
    fimg1 = ImageFrequencyDomainLowPassFilter(img1, tringArgsVector(1));
    fimg2 = ImageFrequencyDomainLowPassFilter(img2, tringArgsVector(1));
    gimg1 = GammaTransform(fimg1, 1, tringArgsVector(2));
    gimg2 = GammaTransform(fimg2, 1, tringArgsVector(3));
    differImg = gimg1 - gimg2;
    bdimg = AutoBinarizeImage(differImg, argsVector(4));
    % Judgement: Make the mark lower.
    mark = sum(sum(abs(bdimg - destimg)));
    markVector(top) = mark;
    top = top + 1;
    dE = lastMark - mark;
    if dE > 0
        % Accept current result.
        argsVector = tringArgsVector;
        lastMark = mark;
    else
        rnd = rand(1);
        border = exp(dE/temp);
        if border > rnd %&& exp(dE/temp) < 1
            argsVector = tringArgsVector;
            lastMark = mark;
        else
            tringArgsVector = argsVector;
        end
    end
    temp = temp*alpha;
    vecSelection = floor(rand()*length(argsVector)) + 1;
%     vecSelection = 1;
    adjustStep = randn(1, 4)*trainingStep;
%     tringArgsVector(vecSelection) = LimitedAdd(tringArgsVector(vecSelection), adjustStep, 0, 1);
    tringArgsVector = VectorLimitedAdd(tringArgsVector, adjustStep, zeros(1, 4), ones(1, 4));
%     if vecSelection == 4
%         fprintf('Adjusted Differ Image Power Ratio. (%.4f)\n', adjustStep);
%         disp(tringArgsVector);
%     end
    trainingTimes = trainingTimes + 1;
end
close all;
imshow(bdimg);