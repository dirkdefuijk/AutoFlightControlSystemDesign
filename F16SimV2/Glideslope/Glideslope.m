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

%% Glideslope Controller
K_c = 1;
W_1 = 0.1;
V_0 = 300; %ft/s
P_0 = V_0*10; %ft (can we assme this?)

%% Stabilize system
s = tf('s');
H_elev = 20.2/(s+20.2);
K_q = -100;






