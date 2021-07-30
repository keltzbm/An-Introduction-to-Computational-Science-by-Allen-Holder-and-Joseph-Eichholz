% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 6
% August 25, 2019

%% Input arguments:

% f - The function whose root is being approximated, either as a function 
% handle or as a string containing a file name.
% a - One endpoint of a bracket of a root of f.
% b - A second endpoint of a bracket of a root of f. An error should occur 
% if [a, b] does not form a bracket of a root.
% epsilon - The convergence criterion on |fxbest|.
% maxitr - The maximum number of iterations to perform.
% loud - An optional variable that defaults to 0. If loud is nonzero, then 
% output in the format indicated below should be produced.

%% Output arguments:

% xbest - The best computed approximation of a root of f.
% fxbest - The value of f at xbest.
% nitr - The number of iterations required to satisfy the convergence
% criterion, counting the initial bracket as iteration 0.
% status - A status variable, encoded as follows:
%   status 0: Success, an xbest such that |fxbest| < epsilon has been
%	found in less than maxitr iterations.
%   status 1: Failure, the iteration limit was reached.
%   status 2: Failure for some other reason, such as epsilon <= 0.

%% Code

function [xbest, fxbest, nitr, status] = Interpolation(f, a, b, epsilon, maxitr, loud)

nitr = 0;
status = NaN;
while isnan(status)
	
	xbest = a - feval(f, a) * (a - b) / (feval(f, a) - feval(f, b));
	fxbest = feval(f, xbest);
	
	if loud
		
		fprintf("Itr: %d, a: %f, b: %f, |b - a|: %e, |f(a)|: %e, |f(b)|: %e, xstar: %f\n", nitr, a, b, abs(b - a), abs(feval(f, a)), abs(feval(f, b)), xbest);
		
	end
	
	if sign(fxbest) == 0 || abs(fxbest) < epsilon
		
		status = 0;
		
	elseif nitr >= maxitr
		
		status = 1;
		
	elseif sign(fxbest) == sign(feval(f, a))
		
		a = xbest;	
		nitr = nitr + 1;
		
	elseif sign(fxbest) == sign(feval(f, b))
		
		b = xbest;
		nitr = nitr + 1;
		
	else
		
		status = 2;
		
	end
	
end

end
