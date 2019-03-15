function PlotGammaTransformFunction(c, b)
    x = 0:0.02:1;
    f = @(x) c*x.^b;
    y = f(x);
    plot(x, y);
end