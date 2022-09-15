% MECH 223 Team 14 Orbiter Launch Simulator ROUND 2
%Add lander's mass and play with spring coefficient, we want the distance
%to be above 3.5 m and the speed to be reasonable. Modify duration too.
% Defining constants
m_orbiter = 0.137;
m_lander = 0;%add lander's mass
m = m_orbiter + m_lander;
g = 9.81;
L = 0.120;
W = 0.515;
H = 0.095;
A = L*W; %Cross sectional area normal to motion
V = L*W*H;
pw = 1.225;%density of air
mu = 0.3;%coefficient of friction
MuR = 0.02;%coefficient of rolling
%spring constant - arbitrary to make sure it passes the gravity within 5 s
%values range 
%total k value for two springs in parallel
k = 9.5; 

%initial parameters for energy
%springlauncher
%arbitrary extension to make sure we pass gravity well in time
x1 = 0.15;
%Unstretched length
x2 = 0.05;
dx = x1-x2;

CD = 1.05;%estimate
delta_t = 0.01;
%modulate time to fit competition rounds 
final_t = 10;
vis = 1.81*10^-5; %viscuosity of air

% Defining arrays
Fd = zeros(final_t/delta_t,0);
a = zeros(final_t/delta_t,0);
F = zeros(final_t/delta_t,0);
v = zeros(final_t/delta_t,0);
x = zeros(final_t/delta_t,0);
t = zeros(final_t/delta_t,0);
N = [0:0.01:final_t];
 
% Forces and initial values
Fg = m*g;
Fk = k*dx;
Froll = 4*MuR*Fg;
Ffr = 2*mu*Fg;

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
disp(v(500));
disp(x(500));
disp('End v:');
disp(v(end));
disp('End x:');
disp(x(end));
% disp(a(end));
% disp(F(end));
% for i = 1:length(N)-1
%     if v(i) > 0.5 && v(i) < 1 && x(i) > 3.4 && x(i) < 3.6
%         disp('FUCK YEAH')
%         break
%     else 
%         disp('Idiot')
%         break
%     end
% end
