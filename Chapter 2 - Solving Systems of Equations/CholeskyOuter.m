% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 12
% February 1, 2021

%% Description:

% Factors a positive definite matrix A into LL', where L is lower
% triangular. The calculation method is to be the outer product algorithm.

%% Input arguments:

% A - A matrix A to be factored. A is not assumed to be positive definite
% or square.

%% Output arguments:

% L - A lower triangular matrix L satisfying LL' = A upon success.
% status - A status variable encoded as follows:
%	status 0: The function succeeded.
% 	status 1: The function failed because A is square but is not positive
% 	definite.
%	status 2: The function failed for some other reason, such as A being
%	non-square.

%% Code:

function [L, status] = CholeskyOuter(A)

tolerance = 1e-8;

[m, n] = size(A);

if m == n
	
	if all(A == A', 'all')
		
		L = zeros(m);
		p = (1:m)';
		
		for i = 1:m
			
			% Pivoting.
			[~, index] = max(abs(A(p(i:end), i)));
			if p(i) ~= p(i - 1 + index)
				
				temp = p(i - 1 + index);
				p(i - 1 + index) = p(i);
				p(i) = temp;
				
			end
			
			if A(p(i), i) ~= 0
				
				C = A(p(i + 1:end), i) / A(p(i), i);
				A(p(i + 1:end), :) = A(p(i + 1:end), :) - C .* A(p(i), :);
				A(p(i), i + 1:end) = 0;
				L(p(i + 1:end), i) = C;
				
			end
			
			L(p(i), i) = 1;
			
		end
		
		if all(diag(A(p, :)) > 0)
			
			L = L(p, :) * sqrt(A(p, :));
			
			if norm(L * L' - A) < tolerance
				status = 0;
			else
				status = 1;
				L = NaN;
			end
			
		else
			
			status = 1;
			L = NaN;
			
		end
		
	else
		
		status = 1;
		L = NaN;
		
	end
	
else
	
	status = 2;
	L = NaN;
	
end

end