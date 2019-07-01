img1 = double(imread('san_1.bmp'));
img2 = double(imread('san_2.bmp'));
patchSize = 5;

fusionDifferMat = FusionDifferDetection(img1, img2);
img1Patches = CutImageIntoPatches(img1, patchSize, patchSize);
img2Patches = CutImageIntoPatches(img2, patchSize, patchSize);
patches = RemoveMeansByRows([img1Patches, img2Patches]);
%% The First Time PCA
[pcaWeight1, pcaEigVal1] = PrincipalComponentAnalysis(patches, 0.9);
pcaValue1 = patches*pcaWeight1;
classification = kMeansClassification(pcaValue1, 2);
