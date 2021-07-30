function d = ProjectileLanding(theta, v, m, alpha, w)
% Return the distanct that a projectile with launch angle theta and initial
% velocity v and mass m will travel if it is in a medium with wind
% resistance coefficient alpha and wind force w.  Use Euler's method with
% tiny step size to intentionally be slow.  
% 
% Units need to be kg for mass, m/s for velocity, rad for angle. 

x = 0;
y = 1e-10;
xp = cos(theta) * v;
yp = sin(theta) * v;
h = 1e-3;
g = 9.8;
% figure;
% hold on;
while y > 0
    x = x + h * xp;
    xp = xp + h * (alpha^2 * w - alpha^2 * xp) / m;
    y = y + h * yp;
    yp = yp + h * (-alpha^2 * yp - m * g) / m;
    % plot(x, y, 'ro');
end
d = x;
