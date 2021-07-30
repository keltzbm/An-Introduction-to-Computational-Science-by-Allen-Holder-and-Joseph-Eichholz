% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 13
% September 2, 2019

f = @(x) cos(x) + 1;
fp = @(x) -sin(x);

a = 3;
b = 3.5;
epsilon = 1e-10;
delta = 1e-10;
x0 = 3;
maxitr = 1000;
loud = 0;

Pi = zeros(1000, 5);

for N = 0:1000
	
	c = zeros(2 * N + 1, 1);
	f = @(x) 1;
	fp = @(x) 0;
	for n = 0:N
	
		f = @(x) (f(x) + (-1)^n * x^(2 * n) / factorial(2 * n));
		fp = @(x) (fp(x) - (-1)^n * x^(2 * n + 1) / factorial(2 * n + 1));
		c(2 * n + 1) = (-1)^n / factorial(2 * n);
	
	end
	
	c(1) = c(1) + 1;
	c = flipud(c);
	
	[xbestB, ~, itrB, statusB] = Bisection(f, a, b, epsilon, delta, maxitr, loud);
	[xbestI, ~, itrI, statusI] = Interpolation(f, a, b, epsilon, maxitr, loud);
	[xbestS, ~, itrS, statusS] = Secant(f, a, b, epsilon, maxitr, loud);
	[xbestN, ~, itrN, statusN] = Newton(f, fp, x0, epsilon, maxitr, loud);
	[xbestNP, ~, itrNP, q, statusNP] = NewtonPoly(c, x0, epsilon, maxitr, loud);
	Pi(N + 1, 1) = xbestB;
	Pi(N + 1, 2) = xbestI;
	Pi(N + 1, 3) = xbestS;
	Pi(N + 1, 4) = xbestN;
	Pi(N + 1, 5) = xbestNP;

end
plot(0:1000, Pi);
legend('Bisection', 'Interpolation', 'Secant', 'Newton', 'Newton Poly.');
