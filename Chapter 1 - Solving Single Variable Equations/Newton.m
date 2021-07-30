% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 8 
% August 25, 2019

%% Input arguments:

% f - The function whose root is being approximated, either as a function
% handle or as a string containing a file name.
% fp - The derivative of f, f'.
% x0 - An initial guess at a root of f.
% epsilon - The convergence criterion on |fxbest|.
% maxitr - The maximum number of iterations to perform.
% loud - An optional argument, with default value 0. If loud is nonzero, 
% then output should be formatted like that of Exercise 7.

%% Output arguments:

% xbest - The computed approximation of a root of f.
% fxbest - The value of f at xbest.
% nitr - The number of iterations required to satisfy the convergence
% criterion, counting x0 as iteration 0 and x1 as iteration 1.
% bracket counts as iteration 0.
% status - A status variable, encoded as follows:
%   status 0: Success, an xbest such that |fxbest| < epsilon has been found
%   in less than maxitr iterations.
%   status 1: Failure, the iteration limit was reached.
%   status 2: Failure for some other reason, such as epsilon <= 0.

%% Code

function [xbest, fxbest, nitr, status] = Newton(f, fp, x0, epsilon, maxitr, loud)

nitr = 0;
status = NaN;
xbest = x0;
while isnan(status)
	
	fxbest = feval(f, xbest);
	
	if loud
		
		fprintf("Itr: %d, x: %f, |f(x)|: %e\n", nitr, xbest, abs(fxbest));
		
	end
	
	if abs(fxbest) < epsilon
		
		status = 0;
		
	elseif nitr >= maxitr
		
		status = 1;
		
	elseif feval(fp, xbest) ~= 0
		
		xbest = xbest - fxbest / feval(fp, xbest);
		nitr = nitr + 1;
		
	else
		
		status = 2;
		
	end
	
end

end
