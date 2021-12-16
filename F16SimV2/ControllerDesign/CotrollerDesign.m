%% Reduce to short period system (states: [alpha;q]).
load("../OpenLoopAnalysis/system_reduced_long.mat");

A_sp_temp = [system_reduced_long.A(2,:); system_reduced_long.A(4,:)];
A_sp = [A_sp_temp(:,2) A_sp_temp(:,4)];
B_sp = [system_reduced_long.B(2,:); system_reduced_long.B(4,:)];
C_sp = eye(2);
D_sp = zeros(2,1);
system_sp = ss(A_sp,B_sp,C_sp,D_sp);

%% Plot step response to state q for reduced system and original system.

figure
hold on
grid on
step(system_reduced_long(4));
step(system_sp(2));
xlim([0 300]);
legend ("System Reduced Long", "System Short Period");


%% Use pole placement for alpha-feedback and q-feedback to get desired characteristics.
h = 40000 * 0.3048; %m
V = 300 * 0.3048; %m/s
omega_sp_req = 0.03*V;
T_theta_2 = 1/(0.75*omega_sp_req);
damping_ratio_sp_req = 0.5;

% Build desired transfer function
s = tf('s');
H_el_servo = 20.2/(s+20.2);
H_el_to_q_desired = minreal((1+T_theta_2)/(s^2+2*damping_ratio_sp_req*omega_sp_req*s+omega_sp_req^2));
poles_desired = pole(H_el_to_q_desired);

% Place poles at desired locations
K = place(system_sp.A, system_sp.B, poles_desired); % [K_alpha K_q]

%% GUSTS

d_alpha = atan(4.572/V); %rad
d_elev = d_alpha * K(1); % /pi*180 // comment on whether this is acceptable

