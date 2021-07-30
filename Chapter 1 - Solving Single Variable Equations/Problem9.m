% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 9
% September 2, 2019

primes = 2:97;
epsilon = 1e-10;
delta = 1e-10;
maxitr = 1000;
loud = 0;

fprintf(" d n | Bis. Int. Sec. Newt.\n");
for d = primes(isprime(primes))

	fprintf("==========================\n"); 
	for n = 2:5
		
		f = @(x) x^n - d;
		fp = @(x) n * x ^ (n - 1);
		[~, ~, itrB, statusB] = Bisection(f, 0, d, epsilon, delta, maxitr, loud);
		[~, ~, itrI, statusI] = Interpolation(f, 0, d, epsilon, maxitr, loud);
		[~, ~, itrS, statusS] = Secant(f, 0, d, epsilon, maxitr, loud);
		[~, ~, itrN, statusN] = Newton(f, fp, d / 2, epsilon, maxitr, loud);

		if n == 2
			fprintf("%2d %d | %4d %4d %4d %4d\n", d, n, itrB, itrI, itrS, itrN);
		elseif statusB ~= 0 
			fprintf("%2s %d | %4s %4d %4d %4d\n", "", n, "*", itrI, itrS, itrN);
		elseif statusI ~= 0 
			fprintf("%2s %d | %4d %4s %4d %4d\n", "", n, itrB, "*", itrS, itrN);
		elseif statusS ~= 0 
			fprintf("%2s %d | %4d %4d %4s %4d\n", "", n, itrB, itrI, "*", itrN);
		elseif statusN ~= 0 
			fprintf("%2s %d | %4d %4d %4d %4s\n", "", n, itrB, itrI, itrS, "*");
		else
			fprintf("%2s %d | %4d %4d %4d %4d\n", "", n, itrB, itrI, itrS, itrN);
		end

	end

end
