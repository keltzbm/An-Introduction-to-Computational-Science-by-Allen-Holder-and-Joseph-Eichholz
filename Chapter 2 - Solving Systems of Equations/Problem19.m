% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 19
% March 10, 2021

%% Description:

% The file RandSspd.m, available at http://www.springer.com, runs as
% [sA, dA] = RandSspd(n). The returns are a sparse positive definite matrix
% sA and a dense perturbation of the same matrix dA. Use tic and toc to
% compare the time required to solve (sA)x = b with your own conjugate
% gradient code versus solving (dA)x = b with \. Use dimensions n = 2^k,
% with k = 5...10.

%% Code:

close all;
clear;
clc;

video = VideoWriter("Problem19.mp4", "MPEG-4");
video.FrameRate = 1;
open(video);

N = 2^10 + 1;

n = zeros(N, 1);
n(1) = 1;
n(2:end) = 2 * (1:N - 1);

times = zeros(N, 2);

fg = figure("Visible", "off");
set(fg, "position", [0, 0, 1920, 1080]);

for p = 1:N
	for k = 1:N
		fprintf("p = %d, n(k) = n(%d) = %d.\n", p, k, n(k));
		
		[sA, dA] = RandSspd(n(k));
		b = rand(n(k), 1);
		
		tic;
		x = dA \ b;
		times(k, 1) = times(k, 1) + toc;
		
		epsilon = norm(dA * x - b);
		
		tic;
		x = ConjugateGradient(sA, b, zeros(n(k), 1), n(k)^2, epsilon);
		times(k, 2) = times(k, 2) + toc;
	
	end
	
	set(0, "CurrentFigure", fg);
	semilogy(n, times / p);
	xlabel('\it n', 'Interpreter', 'latex');
	ylabel('Run Time (s)', 'Interpreter', 'latex');
	xlim([n(1), n(end)]);
	ylim([0.5e-6, 1]);
	
	titleString = ['Observations, $N = $ ', num2str(p), '.'];
	title(titleString, "Interpreter", "latex");
	
	leg = legend('Matlab', 'Linear Solver', "Location", "NorthWest");
	set(leg, "Interpreter", "latex");
	
	writeVideo(video, getframe(fg));
	
end

close(video);
set(fg, "visible", "on");
saveas(fg, "Problem19.jpg", "jpg");