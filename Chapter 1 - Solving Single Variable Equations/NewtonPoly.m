% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 11 
% September 1, 2019

%% Input arguments:

% c - A vector that stores the coefficients of p in order from highest to
% lowest degree.
% x0 - The initial guess at the root.
% epsilon - The convergence tolerance on |p(xbest)|.
% maxitr - The maximum number of iterations to perform.
% loud - An optional argument, with default value 0. If loud is nonzero, 
% then output should be in the same format as Exercise 8.

%% Output arguments:

% xbest - The approximation to a root of p.
% pxbest - The value of p(xbest).
% nitr - The number of iterations required to obtain xbest, with the
% initial guess counted as iteration 0.
% q - The quotient of p upon division by (x - xbest), stored as a vector.
% status - A status variable, encoded as follows:
%   status 0: Success, a value of xbest has been found such that 
%   |p(xbest)| < epsilon in less than maxitr iterations.
%   status 1: Failure, the iteration limit was reached or an iteration xk
%   was found such that p'(xk) = 0.
%   status 2: Failure for some other reason.

%% Code

function [xbest, pxbest, nitr, q, status] = NewtonPoly(c, x0, epsilon, maxitr, loud)

nitr = 0;
status = NaN;
xbest = x0;
while isnan(status)
	
	[pxbest, q] = Horner(c, xbest);
	qxbest = Horner(q, xbest);
	
	if loud
		
		fprintf("Itr: %d, x: %f, |p(x)|: %e\n", nitr, xbest, abs(pxbest));
		
	end
	
	if abs(pxbest) < epsilon
		
		status = 0;
		
	elseif nitr >= maxitr
		
		status = 1;
		
	elseif qxbest ~= 0
		
		xbest = xbest - pxbest / qxbest;
		nitr = nitr + 1;

	else
		
		status = 2;
		
	end
	
end

end
