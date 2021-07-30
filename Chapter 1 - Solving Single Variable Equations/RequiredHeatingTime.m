% Brandon M. Keltz
% An Introduction to Computational Science by Allen Holder and Joseph Eichholz
% Chapter 1 - Solving Single Variable Equations
% Problem 18
% September 6, 2019

%% Description:

% Returns the initial velocity needed to fire a projectile with mass m at
% an initial angle theta if the drag coefficient is alpha and there is a
% wind with velocity w in order to hit a target d meters downrange.

%% Code

function [t, status] = RequiredHeatingTime(MeasurementTime,	MeasurementPosition, HeatingPosition, TargetTemperature)

f = @(x) HeatSimulation(HeatingPosition, 2000, x, MeasurementTime, MeasurementPosition, 0) - TargetTemperature;

a = MeasurementTime;
b = 2 * MeasurementTime;
maximum = HeatSimulation(HeatingPosition, 2000, MeasurementTime, a, MeasurementPosition, 0);
minimum = HeatSimulation(HeatingPosition, 2000, MeasurementTime, b, MeasurementPosition, 0);

itr = 1;
while itr <= 1000 && maximum - minimum > 1e-3 && b - a > 1e-3

	c = (a + b) / 2;
	U = HeatSimulation(HeatingPosition, 2000, MeasurementTime, c, MeasurementPosition, 0);

	if U > maximum
		maximum = U;
		a = c;
	else 
		minimum = U;
		b = c;
	end

	itr = itr + 1;

end

if -5 <= TargetTemperature && TargetTemperature <= maximum
	t = fzero(f, 0);
	status = 0;
else
	t = NaN;
	status = 1;
end

end
