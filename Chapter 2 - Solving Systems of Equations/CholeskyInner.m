% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 13
% February 1, 2021

%% Description:

% Factors a positive definite matrix A into LL', where L is lower
% triangular. The calculation method is to be the inner product algorithm.

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

%% Code

function [L, status] = CholeskyInner(A)

tolerance = 1e-8;

[m, n] = size(A);

if m == n
	
	if all(A == A', 'all')
		
		L = zeros(m);		
		for i = 1:m
			
			D = A(i, i) - L(i, :) * L(i, :)';
			if D > 0
				
				L(i, i) = sqrt(D);
				L(i + 1:end, i) = (A(i + 1:end, i) - L(i + 1:end, :) * L(i, :)') / L(i, i);
				
			else
				
				status = 1;
				L = NaN;
				return;
				
			end
			
		end
		
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
	
	status = 2;
	L = NaN;
	
end

end