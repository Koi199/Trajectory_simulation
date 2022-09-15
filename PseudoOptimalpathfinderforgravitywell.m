% MECH 223 Team 14 Optimal path calculator

% Orbiter mass- 0.137kg
% Landers
% mass in grams
% diameter in mm
% 
% hollow polyprop
% lander1.mass = 2.19;
% lander1.diameter = 25.4;
% 
% hollow aluminium
% lander2.mass = 2.46;
% lander2.diameter = 19;
% 
% nylon 1
% lander3.mass = 4.08;
% lander3.diameter = 19;
% 
% solid polyprop
% lander4.mass = 6.36;
% lander4.diameter = 25.4;
% 
% nylon 2
% lander5.mass = 9.58;
% lander5.diameter = 25.4;
% 
% resin ball
% lander6.mass = 11.51;
% lander6.diameter = 25.4;
% 
% stainless steel
% lander7.mass = 27.82;
% lander7.diameter = 19;

% Defining constants
% Mass of intended object (convert to kg)
m = 1/1000;
% Diameter of Lander to test (convert to m)
d = 19/1000;
% Acceleration due to gravity
g = 9.81;
mu = 0.3;
MuR = 0.02;

% Radius
r = 0.15:0.01:0.45;

%initial path equation of the gravity well
h = -1*(r.^2-0.913*r+0.209)./(4.93*r.^2+r+0.36);
%first derivative to find inclination
dh = -(550109*r.^2-134074*r-53768)./(10*(493*r.^2+100*r+36).^2);
%second derivative
%d2h = (271203737*r.^3-99147723*r.^2-79522872*r-2963468)./(5*(493*r.^2+100*r+36).^3);

% Determining the angle of tilt of the curved path for the lander to go in
% downward acceleration along the changing slope (-ve means downwards)
theta = atan(dh);
a = mu*g*cos(theta) - g*sin(theta);
angle = theta*(180/pi);
% disp(angle)
% disp(a)
% plot(angle, a)
% grid on

for i = 1:length(r)-1
    if a(i) > 0
%         disp(angle(i))
        angle(i)
        optimalangle = theta(i);
        index = i;
        break
    end
end

% horizontal Force equilibrium on a banked circular path
% Using the principle of centripetal force (mv^2/r) and no slip 
v = r(index)*(tan(optimalangle)+mu)/(1-mu*tan(optimalangle))^(0.5);
% disp(v)
v
% disp(r(index))
r(index)
% determining the orientation of the launcher using coordinate geometry
x = 3.5-r(index):0.01:3.5+r(index);
% disp(x)
% y = (r(index)^2-(x(1)-3.5)^2)^(0.5)+1.9;
% disp(y)
% dy = -(x(1)-7/2)/(r(index)^2-(x(1)-7/2)^2)^0.5;
% disp(dy)

% coordinates of the orbiter
a = 3;
b = 1;

for i = 1:length(x)-1
    y = (r(index)^2-(x(i)-3.5)^2)^(0.5)+1.9;
    dy = -(x(i)-7/2)/(r(index)^2-(x(i)-7/2)^2)^0.5;
    z = x(i);

    if (y-b)/(z-a)-dy < 0.0000000001
        magicnumber = dy;
%         disp(magicpoint)
    end
end

% Display the degrees needed for the rotation of the orbiter
 orientation = atan(magicnumber)*(180/pi);
 disp("Rotate the launcher (wrt to +ve x-axis) by:")
 disp(orientation)
 disp('Note that a negative value means that the launcher') 
 disp('has to be rotated wrt to the negative x-axis')
    disp('__||__')
% Estimate the lander path for round 3 & 4


% coordinates of the launcher
a = 3;
b = 1;
% Entrypoint in orbit
x_entry = 3.5 + r(index);
y_entry = 1.9;

x_displacement = x_entry-a;
Y = ['Launch the orbiter on the X-Axis (-ve si to the left, +ve is to the right) by:', num2str(x_displacement), ' m'];
disp(Y)
disp('Shoot the lander so that lander reaches the pre-determined velocity as it enters orbit.')
y_displacement = 1.9 - b;
X = ['The lander has to travel ', num2str(y_displacement) , ' m'];
disp(X)
disp('Use simulation 1 to determine compression needed to reach target speed!')


%Technically not necessary if we got a working solidworks lmao, I m stupid
% % Estimate of orbit time
% % The values for the distance were obtained using the approximation of the length
% % of a curve given by the definite integral sqrt(1+(dy/dx)^2)
% Slope_distance_a = 0.354508;
% Slope_distance_b = 0.15019;
% % Determining average inclination of the slope
% Average_angle = mean(theta);
% 
% % net acceleration down and averaged curved path
% a1 = mu*g*cos(Average_angle) - g*sin(Average_angle);
% a_motion1 = -1*(mu+MuR)*g*cos(Average_angle);
% a_net1 = sqrt(a1^2+a_motion1^2);
% % Constant inclination of second part of the piecewise function
% theta2 = atan(0.051);
% %net acceleration down constant path
% a2 = mu*g*cos(theta2) - g*sin(theta2);
% a_motion2 = -1*(mu+MuR)*g*cos(theta2);
% a_net2 = sqrt(a1^2+a_motion2^2);
% ACC = [a_net1, a_net2];
% % average acceleration
% a_avg = -1*mean(ACC);
% a_avg
% % rough estimate of orbit time
% % Final Speed (V)
% V = 0;
% orbit_time =V-v/a_avg;
% orbit_time
% %first part
% A = 0.5*a1;
% B = v;
% C = -Slope_distance_a;
% %quadratic solver
% delta = (B.^2)-(4*A*C);
% if(delta < 0)      
% disp("Delta < 0 The equation does not have a real root");
% elseif (delta == 0)
%    disp('The equation has only one real roots');
%    time1 = -B./(2*A);
%    disp(time1);  
%    
% else
%    disp('time1 =');
%    timeA =(-B+sqrt(delta))./(2*A);
%    timeB =(-B-sqrt(delta))./(2*A);
%     if timeA > timeB
%         time1 = timeA;
%     elseif timeB > timeA
%         time1 = timeB;
%     end
%     disp(time1);
% end
% 
% %second part
% A = 0.5*a2;
% B = v+a1*time1;
% C = -Slope_distance_b;
% %quadratic solver
% delta = (B.^2)-(4*A*C);
% if(delta < 0)      
% disp("Delta < 0 The equation does not have a real root");
% elseif (delta == 0)
%    disp('The equation has only one real roots');
%    time2 = -B./(2*A);
%    disp(time1);  
%    
% else
%    disp('time1 =');
%    timeA =(-B+sqrt(delta))./(2*A);
%    timeB =(-B-sqrt(delta))./(2*A);
%     if timeA > timeB
%         time2 = timeA;
%     elseif timeB > timeA
%         time2 = timeB;
%     end
%     disp(time2);
% end
% 
% total_timestraightdown = time1+time2;

%first part net time
