% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 17
% September 6, 2019

%% Description:

% Returns the initial velocity needed to fire a projectile with mass m at
% an initial angle theta if the drag coefficient is alpha and there is a
% wind with velocity w in order to hit a target d meters downrange.

%% Code

function v = Velocity(theta, m, alpha, w, d)

f = @(x) ProjectileLanding(theta, x, m, alpha, w) - d;
v = fzero(f, 0);

end
