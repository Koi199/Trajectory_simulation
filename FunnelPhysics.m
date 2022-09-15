%% parameters
% gravity well coefficients
aA = -0.457;
bA = 2.02;
aB = -0.913;
bB = 0.209;
cB = 4.93;
dB = 0.36;

% object parameters
g = 9.81; % gravitational constant
m = 0.01; % mass in kg
x0 = 0;
v0 = 2; % initial velocity in m/s
a0 = 0;

muF = 0.25; % coefficient of friction
muR = 0.26; % rolling resistance


%% gravity well curve
step = 0.0001;

% curve before 0.15
heightA = @(r1) aA + bA*r1;

% curve after 0.15
heightB = @(r2) -(r2.^2 + aB*r2 + bB)./(cB*r2.^2 + r2 + dB);


%% Normal vector direction

r = 0.5;
if r <= 0.15
    height = heightA(r);
    dheight = bA;
else  
    height = heightB(r);
    dheight = (heightB(r) - heightB(r - step))./step;
end

angle = atan(dheight);
angleD = angle*180/pi;


%% Net Force
N = m*g./cos(angle);
Fr = muF*N;
Froll = muR*N;
F0 = Fr;
Fr = Fr - Froll;

Fnet = sqrt(Fr.^2 + (N*sin(angle)).^2);

%%
duration = 3;
dT = 0.0001;

timeSteps = duration/dT;

x = zeros(timeSteps,1);
v = zeros(timeSteps,1);
w = zeros(timeSteps,1);
a = zeros(timeSteps,1);
F = zeros(timeSteps,1);

x(1) = x0;
v(1) = v0;
a(1) = N*sin(angle)/m;
F(1) = F0;
w(1) = v0/r;


for t = 2:timeSteps
    x(t) = x(t-1) + v(t-1)*dT + 0.5*a(t-1)*dT^2;
    v(t) = v(t-1) + a(t-1)*dT;
    w(t) = v(t)/r;
    a(t) = F(t-1)/m;
    
end



