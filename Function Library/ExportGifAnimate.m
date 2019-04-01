function ExportGifAnimate(animateFrame, path)
    framesize = size(animateFrame);
    for i = 1:framesize(2)
        [A, map] = rgb2ind(animateFrame{i}, 256);
        if i == 1
            imwrite(A, map, path, 'gif', 'LoopCount', Inf, 'DelayTime', 0.2);
        else
            imwrite(A, map, path, 'gif', 'WriteMode', 'append', 'DelayTime', 0.2);
        end
    end
end