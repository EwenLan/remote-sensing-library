function answer = LimitedAdd(originalValue, addValue, lowerBorder, higherBorder)
    answer = originalValue + addValue;
    while answer < lowerBorder || answer > higherBorder
        if answer < lowerBorder
            res = answer - lowerBorder;
            answer = lowerBorder - res;
        end
        if answer > higherBorder
            res = answer - higherBorder;
            answer = higherBorder - res;
        end
    end
end