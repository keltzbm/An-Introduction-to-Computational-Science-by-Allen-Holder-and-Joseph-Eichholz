% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 10
% September 2, 2019

%% Input arguments:

% c - A vector that contains the coefficients of p in order from highest to
% lowest degree. For example, p(x) = 4x^3 + 2x + 9 is stored as [4 0 2 9].
% x0 - The point at which p is to be evaluated.

%% Output arguments:

% px - The computed value of p(x0).
% q - A vector that stores the coefficients of the quotient of p(x) upon
% division by (x - x0), stored from highest degree to lowest degree.

%% Code

function [px, q] = Horner(c, x0)

q = zeros(length(c), 1);
q(1) = c(1);

for i = 2:length(c)
	
	q(i) = x0 * q(i - 1) + c(i);
	
end

px = q(end);
q(end) = [];

if isempty(q)

	q = 0;
	
end

end
