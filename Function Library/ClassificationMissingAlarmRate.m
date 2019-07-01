function res = ClassificationMissingAlarmRate(img, standardImg)
    img = double(img);
    standardImg = double(standardImg);
    diff = standardImg - img;
    res = sum(sum(diff > 0))/sum(sum(standardImg > 0));
end