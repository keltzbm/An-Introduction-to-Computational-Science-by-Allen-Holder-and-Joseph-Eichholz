% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 14 
% September 2, 2019

%% Input arguments:

% c - A vector containing the coefficients of p in order from highest to
% lowest degree.
% x0 - A starting point for Newton's method.
% epsilon - A convergence tolerance for Newton's method.
% maxitr - A maximum number of iterations to perform on each application of
% Newton's method.

%% Output arguments:

% r - A vector containing all n roots of p, where n is the degree of p.
% Repeated roots should be listed according to their multiplicity.
% status - A status variable, encoded as follows:
%   status 0: Success
%   status 1: Failure due to Newton's method hitting the iteration limit or
%   due to a zero derivative. r should contain all the roots of p that have
%   been successfully identified in this case.
%   status 2: Failure for some other reason.

%% Code

function [r, status] = AllRoots(c, x0, epsilon, maxitr)

if isreal(x0)
	fprintf("Warning: the input value x0 = %f, is real.\n", x0);
end

q = c;
r = zeros(length(c) - 1, 1);
for k = 1:length(c) - 1

	[r(k), ~, ~, q, status] = NewtonPoly(q, x0, epsilon, maxitr, 0);
	if status ~= 0
		r(k:end) = [];
		break;
	end

end

end
