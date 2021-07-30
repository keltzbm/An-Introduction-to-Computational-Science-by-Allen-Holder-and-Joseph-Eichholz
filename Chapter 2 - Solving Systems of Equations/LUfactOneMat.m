% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 9
% February 4, 2021

%% Description:

% The function should perform an LU factorization of A and return both L
% and U in one matrix rather than in separate matrices. In particular,
% strictly lower triangular entries of L should be stored in the strictly
% lower triangular portion of Afac(p, :) and the upper triangular entries
% of U should be stored in the upper triangular portion of Afac(p, :).

%% Input arguments:

% A - The matrix A to factor; A is not assumed to be square.

%% Output arguments:

% Afac - A matrix with the same dimensions as A. Upon permutation by p, the
% strictly lower triangular portion of Afac(p, :) should contain the strictly
% lower triangular portion of L. The upper triangular portion of Afac(p, :)
% should contain the upper triangular portion of U.
% p - A permutation vector encoding the row swaps necessary during partial
% pivoting.
% status - A status variable encoded as follows:
%	status 0: The code has succeeded.
% 	status 1: The code failed for some reason; the value of L and U should
% 	not be trusted.

%% Code:

function [Afac, p, status] = LUfactOneMat(A)

tolerance = 1e-10;

[m, n] = size(A);

Afac = A;
p = (1:m)';

i = 1;
j = 1;
while i <= m && j <= n
	% Find the index of the largest absolute value in the i-th column.
	[~, index] = max(abs(Afac(p(i:end), j)));
	% Switch the indices if needed.
	if p(i) ~= p(i - 1 + index)
		temp = p(i - 1 + index);
		p(i - 1 + index) = p(i);
		p(i) = temp;
	end
	if Afac(p(i), j) == 0
		j = j + 1;
	else
		C = Afac(p(i + 1:end), j) / Afac(p(i), j);
		Afac(p(i + 1:end), j:end) = Afac(p(i + 1:end), j:end) - C .* Afac(p(i), j:end);
		Afac(p(i + 1:end), i) = C;
		i = i + 1;
		j = j + 1;
	end
end

error = 0;
for i = 1:m
	for j = 1:n
		sum = 0;
		index = 1:min(i - 1, j);
		if ~isempty(index)
			sum = Afac(p(i), index) * Afac(p(index), j);
		end
		if i <= j
			sum = sum + Afac(p(i), j);
		end
		error = error + abs(sum - A(p(i), j))^2;
	end
end

if sqrt(error) < tolerance
	status = 0;
else
	status = 1;
end

end