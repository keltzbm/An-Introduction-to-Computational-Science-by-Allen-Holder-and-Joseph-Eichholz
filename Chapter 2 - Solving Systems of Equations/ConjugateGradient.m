% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 14
% March 11, 2020

%% Description:

% Solves Ax = b with the conjugate gradient method.

%% Input arguments:

% A - The matrix A, which should be tested with chol to ensure that it is
% positive definite.
% b - The right-hand side vector b.
% x0 - An initial guess at the solution to Ax = b.
% maxiter - The maximum number of iterations to perform.
% epsilon - The convergence tolerance, the code should stop iterating once
% ||Ax_n - b|| < epsilon.

%% Output arguments:

% x - The computed approximate solution to Ax = b.
% itr - The number of iterations performed by the code.
% status - A status variable, encoded as follows:
%	status 0: The algorithm completed successfully.
% 	status 1: The algorithm reached the maximum number of iterations
% 	without finding an approximate solution.
%	status 2: The algorithm encountered some other error.

%% Code

function [x, itr, status] = ConjugateGradient(A, b, x0, maxiter, epsilon)

itr = 0;
status = NaN;
[m, n] = size(A);

if all([m, 1] == size(x0)) && all([n, 1] == size(b))
	
	x = x0;
	d = -(A * x - b);
	
	while isnan(status)
		
		if norm(A * x - b) <= epsilon
			
			status = 0;
			
		elseif itr >= maxiter
			
			status = 1;
			
		else
			
			x = x - (A * x - b)' * d * d / (d' * A * d);
			d = -(A * x - b) + d' * A * (A * x - b) * d / (d' * A * d);
			itr = itr + 1;
			
		end
		
	end
	
else
	
	x = NaN;
	status = 2;
	
end