% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 16
% February 2, 2021

%% Description:

% Attempts to solve the nonlinear system f(x) = 0 with Newton's method,
% where f: R^n -> R^n.

%% Input arguments:

% f - A function handle or filename that defines f(x). Assume that f(x) is
% a column vector.
% df - A function handle or filename that defines D_x f(v). Assume that D_x
% f(v) is always a matrix with dimensions consistent with f(v).
% x0 - An initial guess at a solution to f(x) = 0. Check to ensure that x0
% is a column vector.
% epsilon - The termination tolerance. Quit if ||f(x_n)|| < epsilon.
% maxiter - An iteration limit.

%% Output arguments:

% x - The computed solution x.
% nrmfx - The value of ||f(x)|| at the computed solution.
% numitr - The number of iterations used to compute the solution.
% status - The status of the search, encoded as follows:
%	status 0: The code was successful.
% 	status 1: The code reached the iteration limit before finding an
% 	acceptable solution.
%	status 2: Some other problem occurred, for instance x0 was not a column
%	vector.

%% Code:

function [x, nrmfx, numitr, status] = NewtonSys(f, df, x0, epsilon, maxiter)

numitr = 0;
[m, n] = size(df(zeros(length(x0), 1)));

if all([m, 1] == size(x0)) && all([n, 1] == size(f(zeros(n, 1))))
	
	status = NaN;
	x = x0;
	
	while isnan(status)
		
		[dx, singular] = LinearSolver(df(x), -f(x));
		nrmfx = norm(f(x));
		
		if nrmfx < epsilon
			
			status = 0;
			
		elseif numitr >= maxiter
			
			x = NaN;
			nrmfx = NaN;
			status = 1;
			
		elseif singular
			
			x = NaN;
			nrmfx = NaN;
			status = 2;
			
		else
			
			x = x + dx;
			numitr = numitr + 1;
			
		end
		
	end
	
else
	
	x = NaN;
	nrmfx = NaN;
	status = 2;
	
end

end