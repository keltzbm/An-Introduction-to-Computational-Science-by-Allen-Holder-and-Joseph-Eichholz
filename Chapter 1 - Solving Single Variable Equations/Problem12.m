% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 12
% September 6, 2019

f = @(x) cos(x) + 1;
fp = @(x) -sin(x);

a = 3;
b = 3.5;
epsilon = 1e-10;
delta = 1e-10;
maxitr = 1000;
loud = 0;

[xbestB, ~, itrB, statusB] = Bisection(f, a, b, epsilon, delta, maxitr, loud);
[xbestI, ~, itrI, statusI] = Interpolation(f, a, b, epsilon, maxitr, loud);
[xbestS, ~, itrS, statusS] = Secant(f, a, b, epsilon, maxitr, loud);
[xbestN, ~, itrN, statusN] = Newton(f, fp, 3, epsilon, maxitr, loud);

fprintf('Bisection estimation of Pi = %f.\n', xbestB);
fprintf('Interpolation estimation of Pi = %f.\n', xbestI);
fprintf('Secant estimation of Pi = %f.\n', xbestS);
fprintf('Newton estimation of Pi = %f.\n', xbestN);
