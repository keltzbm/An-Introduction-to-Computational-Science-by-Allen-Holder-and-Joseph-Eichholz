% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 2 - Solving Systems of Equations
% Problem 18
% March 31, 2021

%% Description:

% Use the tic and toc commands to compare the run time of your LinearSolver
% routine from Exercise 6 versus the backslash command \ in MATLAB. Use
% random n x n matrices A and random n x 1 vectors b where n = 10^k, with 
% k = 1, 2, 3, 4 as the basis of your comparison. You should find that \ is
% extremely efficient.

%% Code:

close all;
clear;
clc;

video = VideoWriter("Problem18.mp4", "MPEG-4");
video.FrameRate = 1;
open(video);

N = 10^4;

n = zeros(N, 1);
n(1) = 1;
n(2:end) = 2 * (1:N - 1);

times = zeros(N, 2);

fg = figure("Visible", "off");
set(fg, "position", [0, 0, 1920, 1080]);

for p = 1:N / 4
	for n = 1:N
		fprintf("p = %d, n = %d.\n", p, n);
		
		A = rand(n);
		x = rand(n, 1);
		b = A * x;
		
		tic;
		A \ b;
		times(n, 1) = times(n, 1) + toc;
		
		tic;
		LinearSolver(A, b);
		times(n, 2) = times(n, 2) + toc;
	
	end
	
	set(0, "CurrentFigure", fg);
	semilogy(times / p);
	xlabel('\it n', 'Interpreter', 'latex');
	ylabel('Run Time (s)', 'Interpreter', 'latex');
	xlim([1, N]);
% 	ylim([0.5e-6, 1]);
	
	titleString = ['Observations, $N = $ ', num2str(p), '.'];
	title(titleString, "Interpreter", "latex");
	
	leg = legend('Matlab', 'Linear Solver', "Location", "NorthWest");
	set(leg, "Interpreter", "latex");
	
	writeVideo(video, getframe(fg));
	
end

close(video);
set(fg, "visible", "on");
saveas(fg, "Problem18.jpg", "jpg");