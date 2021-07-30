% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Unit Tests
% February 1, 2021


% programs = ["LinearSolver", "LUfact_NoPivot", "LUfact", "LUfactOneMat", ...
% 	"Backsolve", "CholeskyOuter", "CholeskyInner", "ConjugateGradient", ...
% 	"NewtonSys", "TDMS"];
%
% for i = 1:length(programs)
%
%
%
% end

N = 35;
tolerance = 1e-6;
matrixDims = 100;
matrixValues = 100;

for i = 1:2
	
	j = 1;
	pass = 1;
	while j <= N && pass
		
		m = randi(matrixDims);
		n = randi(matrixDims);
		
		A = matrixValues * (2 * rand(m, n) - 1);
		x = matrixValues * (2 * rand(n, 1) - 1);
		b = A * x;
		if m < n
			s = 1;
		else
			s = 0;
		end
		
		[xstar, status] = LinearSolver(A, b);
		
		if s ~= status || ~(isequaln(x, xstar) || norm(A * xstar - b) < tolerance)
			pass = 0;
		end
		j = j + 1;
	end
	
end