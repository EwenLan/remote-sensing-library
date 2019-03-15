function PlotLogTransformFunction(c)
    x = 0:0.002:1;
    f = @(x) log(1 + c*x)/log(c + 1);
    y = f(x);
    plot(x, y);
end