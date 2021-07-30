% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 7
% February 4, 2021

%% Description:

% Factors a matrix A into the product LU. The algorithm should not perform
% pivoting.

%% Input arguments:

% A - The matrix A to be factored; A is not assumed to be square.

%% Output arguments:

% L - A square lower triangular matrix L, with ones on the main diagonal.
% U - An upper triangular matrix U, with the property that LU = A if the
% code succeeds.
% status - A status variable encoded as follows:
%	status 0: The code has succeeded.
% 	status 1: The code failed for some reason; the value of L and U should
% 	not be trusted.

%% Code:

function [L, U, status] = LUfact_NoPivot(A)

tolerance = 1e-10;

[m, n] = size(A);

L = eye(m);
U = A;

i = 1;
j = 1;
while i <= m && j <= n
	if U(i, j) == 0
		j = j + 1;
	else
		C = U(i + 1:end, j) / U(i, j);
		U(i + 1:end, :) = U(i + 1:end, :) - C .* U(i, :);
		L(i + 1:end, i) = C;
		i = i + 1;
		j = j + 1;
	end	
end

if norm(L * U - A) < tolerance
	status = 0;
else
	status = 1;
end

end