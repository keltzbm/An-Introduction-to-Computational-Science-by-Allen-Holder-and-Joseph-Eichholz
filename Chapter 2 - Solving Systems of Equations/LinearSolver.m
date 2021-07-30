% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 6
% February 4, 2021

%% Description:

% Attempts to solve Ax = b by row reducing the augmented matrix [A|b]. The
% algorithm should incorporate row pivots and should use the technique of
% backsolving once [A|b] is reduced to an upper triangular form. A should
% not be assumed to be square, and the dimensions of b should not be
% assumed to be consistent with those of A.

%% Input arguments:

% A - The coefficient matrix A of the linear system.
% b - The right-hand side vector b of the linear system. The code should
% return an error status if b is not a column vector or has dimensions that
% are inconsistent with A. See the status definition.

%% Output arguments:

% x - A solution to Ax = b if one exits.
% status - A status variable encoded as follows:
%	status 0: Ax = b is consistent with a unique solution.
% 	status 1: Ax = b is consistent with an infinite number of solutions. In
% 	this case a solution to the linear system should be returned in x.
%	status 2: Ax = b is inconsistent.
% 	status 3: The code did not succeed for some other reason, such as
% 	inconsistent dimensions of A and b.

%% Code:

function [x, status] = LinearSolver(A, b)

% Tolerance for approximation of zeros.
tolerance = 1e-6;

[m, n] = size(A);
x = NaN;

% Ensure that dimensions are correct.
if all([m, 1] == size(b))
	
	status = 0;
	
	% Permutation vector for pivoting.
	p = (1:m)';
	i = 1;
	j = 1;
	while i <= m && j <= n
		
		% Find the index of the largest absolute value in the i-th column.
		[~, index] = max(abs(A(p(i:end), j)));
		% Switch the indices if needed.
		if p(i) ~= p(i - 1 + index)
			temp = p(i - 1 + index);
			p(i - 1 + index) = p(i);
			p(i) = temp;
		end
		
		if A(p(i), j) == 0
			j = j + 1;
		else
			C = A(p(i + 1:end), j) / A(p(i), j);
			A(p(i + 1:end), :) = A(p(i + 1:end), :) - C .* A(p(i), :);
			b(p(i + 1:end)) = b(p(i + 1:end)) - C .* b(p(i));
			i = i + 1;
			j = j + 1;
		end
		
	end
	
	% Backsolve Algorithm.
	x = zeros(n, 1);
	i = min(m, n);
	j = i;
	while 1 <= i
		
		if A(p(i), j) == 0
			if j == n
				if b(p(i)) == 0
					status = 1;
				else
					status = 2;
					x = NaN;
					return;
				end
				i = i - 1;
				j = i;
			else
				j = j + 1;
			end
		else
			x(j) = (b(p(i)) - A(p(i), :) * x) / A(p(i), j);
			i = i - 1;
			j = i;
		end
		
	end
	
else
	
	status = 3;
	
end

end