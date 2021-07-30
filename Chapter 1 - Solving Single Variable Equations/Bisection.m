% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 5
% July 15, 2019

%% Input arguments:

% f - The function whose root is being approximated. Bisection should
% accept f either as a string containing a file name or as a function
% handle.
% a - An endpoint of the search interval.
% b - A second endpoint of the search interval. An error should occur if
% [a, b] does not form a bracket of a root.
% epsilon - A convergence criterion on |fxbest|.
% delta - A convergence criterion on |xstar - xbest|, where xstar is an
% exact root of f. The code should terminate when both |xstar - xbest| <
% delta is guaranteed and |fxbest| < epsilon, or when fxbest = 0.
% maxitr - The maximum number of iterations that should be calculated.
% loud - An optional variable that defaults to 0. If loud is nonzero, then
% the code should produce output in the format below.

%% Output arguments:

% xbest - The best computed approximation of a root of f, i.e. the value of
% x with the smallest observed value of |f|.
% fxbest - The value of f at xbest.
% nitr - The number of iterations used to compute xbest, where the initial
% bracket counts as iteration 0.
% status - A status variable encoded as follows:
%   status 0: Success, meaning that either both convergence criteria are
%   satisfied or that an exact root is calculated. Use sign(fxbest) == 0 as
%   the test for the latter case.
%   status 1: Failure, the iteration limit was reached.
%   status 2: Some failure other than the iteration limit occurred. For
%   example, [a, b] does not form a bracket of a root of f, epsilon <= 0,
%   or delta <= 0.

%% Code

function [xbest, fxbest, nitr, status] = Bisection(f, a, b, epsilon, delta, maxitr, loud)

nitr = 0;
status = NaN;
while isnan(status)
	
	xbest = (a + b) / 2;
	fxbest = feval(f, xbest);
	
	if loud
		
		fprintf("Itr: %d, a: %f, b: %f, |b - a|: %e, |f(a)|: %e, |f(b)|: %e, xstar: %f\n", nitr, a, b, abs(b - a), abs(feval(f, a)), abs(feval(f, b)), xbest);
		
	end
	
	if sign(fxbest) == 0 || (abs(fxbest) < epsilon && abs(b - a) < delta)
		
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
