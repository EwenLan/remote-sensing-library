function ProgressBar(pg)
    for i = 1:70
        fprintf('\b');
    end
    fprintf('[');
    sharps = ceil(pg*60);
    spaces = 60 - sharps;
    for i = 1:sharps
        fprintf('#');
    end
    for i = 1:spaces
        fprintf(' ');
    end
    fprintf('] %6.2f%%', pg*100);
    if pg == 1
        fprintf('\n');
    end
end