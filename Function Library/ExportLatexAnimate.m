function ExportLatexAnimate(frameArrays, folderPath)
    if exist(folderPath, 'dir')
        rmdir(folderPath, 's');
    end
    mkdir(folderPath);
    framesize = size(frameArrays);
    for i = 1:framesize(2)
        imwrite(frameArrays{i}, sprintf('%s/frame-%04d.png', folderPath, i));
    end
end