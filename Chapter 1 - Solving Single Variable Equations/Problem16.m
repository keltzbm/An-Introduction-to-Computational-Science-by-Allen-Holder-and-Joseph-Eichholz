% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 16
% September 4, 2019

f = @(x) sin(x);
fp = @(x) cos(x);

epsilon = 1e-10;
delta = 1e-10;
maxitr = 1000;
loud = 0;

hold on;
for x0 = 0:0.0001:pi / 2

	[xbest, fxbest, nitr, status] = Newton(f, fp, x0, epsilon, maxitr, loud);
	plot(x0, nitr, 'r*');

end
hold off;
