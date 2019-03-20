function answer = VectorLimitedAdd(originalVector, addVector, lowerBorder, higherBorder)
    f = @(x, y, z, k) LimitedAdd(x, y, z, k);
    answer = arrayfun(f, originalVector, addVector, lowerBorder, higherBorder);
end