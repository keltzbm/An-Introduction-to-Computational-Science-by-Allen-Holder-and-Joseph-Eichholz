% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problems 10 and 11
% February 4, 2021

%% Description:

% Solves Ax = b after A has been factored into LU up to permutation by p.
% The algorithm is the two-step process in (2.6).
% Step 1: Solving Ly = b, and
% Step 2: Solving Ux = y.

%% Input arguments:

% L - A square lower triangular square matrix L with ones on the main
% diagonal.
% U - An upper triangular matrix U. L and U are not assumed to have
% consistent dimensions.
% Afac - A matrix with the same dimensions as A. Upon permutation by p, the
% strictly lower triangular portion of Afac(p, :) should contain the strictly
% lower triangular portion of L. The upper triangular portion of Afac(p, :)
% should contain the upper triangular portion of U.
% p - A permutation vector p. It is assumed that LU = A(p, :).
% b - The right-hand side vector in Ax = b, b is not assumed to have
% consistent dimensions with A.

%% Output arguments:

% x - A solution x to Ax = b if the problem is consistent.
% status - A status variable encoded as follows:
%	status 0: Ax = b is consistent with a unique solution.
% 	status 1: Ax = b is consistent with an infinite number of solutions, in
% 	which case a solution to Ax = b is returned in x.
%	status 2: Ax = b is inconsistent.
% 	status 3: The function failed for some other reason, such as input
% 	arguments with inconsistent dimensions.

%% Code:

function [x, status] = Backsolve(varargin)

tolerance = 1e-8;
x = NaN;

if length(varargin) == 3
	
	[Afac, p, b] = varargin{:};
	
	[m, n] = size(Afac);
	
	if all([m, 1] == size(b))
		
		status = 0;
		
		y = zeros(m, 1);
		for i = 1:m
			y(i) = b(p(i)) - Afac(p(i), 1:min(i, n)) * y(1:min(i, n));
		end
		
		% Backsolve Algorithm.
		x = zeros(n, 1);
		i = min(m, n);
		j = i;
		while 1 <= i
			
			if Afac(p(i), j) == 0
				if j == n
					if y(i) == 0
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
				x(j) = (y(i) - Afac(p(i), :) * x) / Afac(p(i), j);
				i = i - 1;
				j = i;
			end
			
		end
		
	else
		
		status = 3;
		
	end
	
elseif length(varargin) == 4
	
	[L, U, p, b] = varargin{:};

	[m, n] = size(U);
	
	if all(m == size(L)) && all([m, 1] == size(b))
		
		status = 0;
		
		y = zeros(m, 1);
		for i = 1:m
			y(i) = b(p(i)) - L(i, :) * y;
		end
		
		% Backsolve Algorithm.
		x = zeros(n, 1);
		i = min(m, n);
		j = i;
		while 1 <= i
			
			if U(i, j) == 0
				if j == n
					if y(i) == 0
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
				x(j) = (y(i) - U(i, :) * x) / U(i, j);
				i = i - 1;
				j = i;
			end
			
		end
		
	else
		
		status = 3;
		
	end
	
else
	
	status = 3;
	
end

end