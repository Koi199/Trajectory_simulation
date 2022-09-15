% MECH 223 Team 14 Orbiter Launch Simulator
%Add lander's mass and play with spring coefficient, we want the distance
%to be above 3.5 m and the speed to be reasonable
% Defining constants
m_orbiter = 0.112;
m_lander = 0.00958;%add lander's mass
m = m_orbiter + m_lander;
g = 9.81;
D = 0.05;
A = 0.120*0.0515; %Cross sectional area normal to motion
V = 0.095*0.120*0.0515;
%spring constant - arbitrary to make sure it passes the gravity within 5 s
%values range from 114 to 124
k = 124; 
pw = 1.225;
mu = 0.25;
MuR = 0.26;

%initial parameters for energy
%springlauncher
x1 = 0.05;
x2 = 0.03;%arbitrary compression to make sure we pass gravity well in time
dx = x1-x2;

CD = 0.5;%estimate
delta_t = 0.01;
final_t = 5;
vis = 1.81*10^-5; %viscuosity of air

% Defining arrays
Fd = zeros(final_t/delta_t,0);
a = zeros(final_t/delta_t,0);
F = zeros(final_t/delta_t,0);
v = zeros(final_t/delta_t,0);
x = zeros(final_t/delta_t,0);
t = zeros(final_t/delta_t,0);
N = [0:0.01:5];
 
% Forces and initial values
Fg = m*g;
Fk = k*dx;
Froll = 4*MuR*Fg;
Ffr = 4*mu*Fg;

x(1) = 0;
v(1) = 0;
F(1) = 0;
a(1) = F(1)/m;
t(1) = 0;
Fd(1) = 0;


% Use a for loop to find corresponding values for each quantity with respect
% to time
for t_int = 1:length(N)-1
 
   % Determines velocity
   v(t_int+1) = v(t_int) + a(t_int)*delta_t;
   % Determines displacement
   x(t_int+1) = x(t_int) +v(t_int)*delta_t+0.5*a(t_int)*delta_t^2;
   % Determines acceleration
   a(t_int+1) = F(t_int)/m;
   t(t_int+1) = t(t_int) + delta_t;
  
   % Determines drag force
   Fd = 0.5*pw*v(t_int)^2*CD*A;
   % Determines net force
   F(t_int+1) = Fk-Froll-Ffr-Fd;
end

% Plot relevant graphs
% plot(t, a);
% hold on
% plot(t, v);
% plot(t, x);
% xlabel('Time (s)');
% title('Simulation Part 3');
% legend('Acceleration (m/s^2)','Velocity (m/s)','Position (m)');
% grid on % 

% Check the final values
disp(v(end));
disp(x(end));
% disp(a(end));
% disp(F(end));
