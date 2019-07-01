function res = ClassificationFalseAlarmRate(img, standardImg)
    img = double(img);
    standardImg = double(standardImg);
    diff = img - standardImg;
    res = sum(sum(diff > 0))/sum(sum(standardImg < 1));
end