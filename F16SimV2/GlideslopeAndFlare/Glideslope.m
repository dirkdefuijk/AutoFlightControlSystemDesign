%% Reduce trimmed & linearized model.
load("Trim_5000_300.mat");

A_temp = [SS_long_lo.A(1,:);
          SS_long_lo.A(3,:);
          SS_long_lo.A(4,:);
          SS_long_lo.A(2,:);
          SS_long_lo.A(5,:)];

A_reduced = [A_temp(:,1) A_temp(:,3) A_temp(:,4) A_temp(:,2) A_temp(:,5)];

B_reduced = [SS_long_lo.A(1,6:7); SS_long_lo.A(3,6:7); SS_long_lo.A(4,6:7); SS_long_lo.A(2,6:7); SS_long_lo.A(5,6:7)];

sys_reduced = ss(A_reduced, B_reduced, eye(5), zeros(5,2));

set(sys_reduced,'StateName',["h" "V_t" "alpha" "theta" "q"]);
set(sys_reduced, 'InputName',["delta_thr" "delta_el"]);
set(sys_reduced, 'OutputName',["h" "V_t" "alpha" "theta" "q"]);
save sys_reduced_glideslope.mat sys_reduced

%% Saturation Limits
min_dev_thrust = 1000 - trim_thrust_lo;
max_dev_thrust = 19000 - trim_thrust_lo;

min_dev_elevator = -25 - trim_control_lo(1);
max_dev_elevator = 25 - trim_control_lo(1); 


%% Initial Values

x0 = 3000 + 2000/(3*pi/180);
y0 = 2000;
coeff_x=x0/sqrt(x0^2+y0^2);
coeff_y=y0/sqrt(x0^2+y0^2);
alpha0 = trim_state_lo(8);
theta0 = trim_state_lo(5);

%% Flare

h_dot_h_flare = 300*sin(-3/180*pi);
x_flare_1 = 1100;
tau = 1.2217;
x_flare_2 = 299.5891*tau;
% control law: h_dot = -h/tau = -0.8185*h
h_flare = 19.1817;



