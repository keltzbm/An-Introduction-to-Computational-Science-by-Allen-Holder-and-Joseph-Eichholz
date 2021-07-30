% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 17
% February 13, 2021

%% Description:

% Solves the system of equations Ax = b if A is tridiagonal. Extend the
% idea of fast forward substitution to implement a fast backward
% substitution, and combine these substitution routines with the
% tridiagonal LU factorization to complete the task of solving Ax = b in
% about 5n calculations. Note that this algorithm may not always complete
% successfully even if A is invertible, as it does not implement any
% pivoting.

%% Input arguments:

% A - The coefficient matrix A of the linear system.

%% Output arguments:

% x - A solution to Ax = b if one exits.
% status - A status variable encoded as follows:
%	status 0: Ax = b is consistent with a unique solution.
% 	status 1: Ax = b is consistent with an infinite number of solutions. In
% 	this case a solution to the linear system should be returned in x.
%	status 2: Ax = b is inconsistent.

%% Code

function [x, status] = TDMS(A, b)

[m, n] = size(A);
x = NaN;

if all([m, 1] == size(b))
	
	status = 0;
	
	L = zeros(m - 1, 1);
	
	i = 1;
	j = 1;
	while i <= m - 1 && j <= n
		if A(i, j) == 0
			j = j + 1;
		else
			L(i) = A(i + 1, j) / A(i, j);
			A(i + 1, :) = A(i + 1, :) - L(i) * A(i, :);
			i = i + 1;
			j = j + 1;
		end
	end
	
	% Ly = b.
	y = zeros(m, 1);
	y(1) = b(1);
	for i = 2:m
		y(i) = b(i) - L(i - 1) * y(i - 1);
	end
	
	% Ux = y.
	x = zeros(n, 1);
	for i = min(m, n):-1:1
		j = min(i + 1, n);
		if A(i, i) == 0
			if A(i, j) == 0
				if y(i) == 0
					status = 1;
				else
					status = 2;
					x = NaN;
					return;
				end
			else
				x(i + 1) = y(i) / A(i, i + 1);
			end
		else
			x(i) = (y(i) - A(i, j) * x(j)) / A(i, i);
		end
	end
	
else
	
	status = 3;
	
end

end