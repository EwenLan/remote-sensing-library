x = 0:0.01:1;
f = @(x) 1 - x;
y = f(x);
plot(x, y);
saveas(gcf, '../../Document/figure/DJI_0027_Reversed_Graph.eps');
close;