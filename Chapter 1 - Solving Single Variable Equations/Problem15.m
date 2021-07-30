% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 15
% September 3, 2019

f = @(x) (x >= 0) * x^2 / (1 + x^2) - (x < 0) * x^2 / (1 + x^2);
fp = @(x) (x >= 0) * 2 * x / (1 + x^2)^2 - (x < 0) * 2 * x / (1 + x^2)^2;

epsilon = 1e-10;
delta = 1e-10;
maxitr = 1000;
loud = 0;

hold on;
for x0 = 0:0.001:1 

	[xbest, fxbest, nitr, status] = Newton(f, fp, x0, epsilon, maxitr, loud);
	% [xbest, fxbest, nitr, status] = Bisection(f, a, abs(a), epsilon, delta, maxitr, loud);

	plot(x0, xbest, 'r*');

end
hold off;
