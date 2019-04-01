function ExportLatexAnimate(frameArrays, path)
    framesize = size(frameArrays);
    for i = 1:framesize(2)
        imwrite(frameArrays{i}, sprintf('%s-%04d.png', path, i));
    end
end