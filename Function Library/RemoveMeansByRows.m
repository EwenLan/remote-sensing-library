function res = RemoveMeansByRows(mat)
    matMean = mean(mat, 2);
    res = mat - matMean;
end