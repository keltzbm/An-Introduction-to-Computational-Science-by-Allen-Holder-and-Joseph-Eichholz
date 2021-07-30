% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 8
% February 4, 2021

%% Description:

% The function should factor the matrix A into the product LU up to a
% permutation. The algorithm should perform row swaps so that the pivot is
% always the largest magnitude element of the appropriate column.

%% Input arguments:

% A - The matrix A to be factored; A is not assumed to be square.

%% Output arguments:

% L - A square lower triangular matrix with ones along the main diagonal.
% U - An upper triangular matrix.
% p - A permutation vector. The equality LU == A(p, :) should be very
% nearly true in every position.
% status - A status variable encoded as follows:
%	status 0: The code has succeeded.
% 	status 1: The code failed for some reason; the value of L and U should
% 	not be trusted.

%% Code:

function [L, U, p, status] = LUfact(A)

tolerance = 1e-10;

[m, n] = size(A);

L = zeros(m);
U = A;
p = (1:m)';

i = 1;
j = 1;
while i <= m && j <= n
	% Find the index of the largest absolute value in the i-th column.
	[~, index] = max(abs(U(p(i:end), j)));
	% Switch the indices if needed.
	if p(i) ~= p(i - 1 + index)
		temp = p(i - 1 + index);
		p(i - 1 + index) = p(i);
		p(i) = temp;
	end
	if U(p(i), j) == 0
		if j == n
			L(p(i), i) = 1;
		end
		j = j + 1;
	else
		C = U(p(i + 1:end), j) / U(p(i), j);
		U(p(i + 1:end), :) = U(p(i + 1:end), :) - C .* U(p(i), :);
		L(p(i + 1:end), i) = C;
		L(p(i), i) = 1;
		i = i + 1;
		j = j + 1;
	end	
end

L(p(n + 1:end), n + 1:end) = eye(m - n);

L = L(p, :);
U = U(p, :);

if norm(L * U - A(p, :)) < tolerance
	
	status = 0;
	
else
	
	status = 1;
	
end

end