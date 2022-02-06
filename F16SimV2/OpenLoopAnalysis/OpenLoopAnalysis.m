load("Trim_40000_300.mat");

%% LONGITUDINAL

% get A_ac B_ac
A_temp = [SS_long_lo.A(3,:);SS_long_lo.A(4,:);SS_long_lo.A(2,:);SS_long_lo.A(5,:)];
A_ac_long = [A_temp(:,3) A_temp(:,4) A_temp(:,2) A_temp(:,5)];
B_ac_long = [SS_long_lo.A(3,7);SS_long_lo.A(4,7);SS_long_lo.A(2,7);SS_long_lo.A(5,7)];

a = 20.2;
A_overall_long = [A_ac_long B_ac_long;0 0 0 0 -a];
B_overall_long = [0;0;0;0;a];
C_overall_long = eye(5);
D_overall_long = 0;

% SAVE LONG MODEL W/O ACTUATOR DYNAMICS
system_reduced_long = ss(A_ac_long,B_ac_long,eye(4),zeros(4,1));
set(system_reduced_long,'StateName',["V_t" "alpha" "theta" "q"]);
set(system_reduced_long, 'InputName',["u_el"]);
set(system_reduced_long, 'OutputName', ["V_t" "alpha" "theta" "q"]);
save system_reduced_long.mat system_reduced_long

%% LATERAL

% get A_ac
A_OL = [SS_lat_lo.A(4,:); SS_lat_lo.A(1,:); SS_lat_lo.A(5,:); SS_lat_lo.A(6,:)];
A_ac_lat = [A_OL(:,4) A_OL(:,1) A_OL(:,5) A_OL(:,6)]; %4x4  

% extract B_ac matrix from how the states are composed of the input angles
B_ac_lat = [SS_lat_lo.A(4,8:9);SS_lat_lo.A(1,8:9);SS_lat_lo.A(5,8:9);SS_lat_lo.A(6,8:9)]; %4x2

% define the actuator dynamics
a = 20.2;
b = 20.2;

% d/dt(d_ail) = -a*d_ail + u_ail
A_overall_lat = [A_ac_lat B_ac_lat;
    0 0 0 0 -a 0; 
    0 0 0 0 0 -b];
B_overall_lat = [0 0;0 0;0 0;0 0;a 0; 0 b];
C_overall_lat = eye(6);
D_overall_lat = zeros(6,2);

% SAVE LAT MODEL W/O ACTUATOR DYNAMICS
system_reduced_lat = ss(A_ac_lat,B_ac_lat,eye(4),zeros(4,2));
set(system_reduced_lat,'StateName',["beta" "phi" "p" "r"]);
set(system_reduced_lat, 'InputName',["delta_a" "delta_r"]);
set(system_reduced_lat, 'OutputName', ["beta" "phi" "p" "r"]);
save system_reduced_lat.mat system_reduced_lat

%% Test
s = tf('s');
H_elev = a/(s+a);
sys_ac_long = ss(A_ac_long,B_ac_long,eye(4),0);
H_OL_long = H_elev*sys_ac_long;

H_ail = a/(s+a);
H_rud = a/(s+a);
sys_ac_lat = ss(A_ac_lat,B_ac_lat,eye(4),zeros(4,2));
H_OL_lat = H_ail*sys_ac_lat;

%% Daming ratio, natural frequency and time to half amplitude
% LONGITUDINAL
[wn_long,zeta_long,p_long] = damp(system_reduced_long);
period_sp = 1/(wn_long(3)/2/pi);
period_phugoid = 1/(wn_long(1)/2/pi);

T_half_sp = -log(1/2)/zeta_long(3)/wn_long(3);
T_half_phugoid = -log(1/2)/zeta_long(1)/wn_long(1);

% LATERAL
[wn_lat,zeta_lat,p_lat] = damp(system_reduced_lat);
period_dutchroll = 1/(wn_lat(3)/2/pi);

T_half_dutchroll = -log(1/2)/zeta_lat(3)/wn_lat(3);


%% Plot time responses

% short period
figure

t_sp = 0:0.001:15;
initial(system_reduced_long(2),[0,0.01,0,0],t_sp);
xline(T_half_sp)
grid on
ylabel("alpha [rad]")
% phugoid
figure
t_phugoid = 0:0.001:200;
initial(system_reduced_long(1),[0,0,0.1,0],t_phugoid);
xline(T_half_phugoid);
grid on
ylabel("V [ft/s]")
% dutch roll
figure
t_dr = 0:0.001:50;
initial(system_reduced_lat(1,1),[0.1,0,0,0],t_dr);
xline(T_half_dutchroll);
grid on
ylabel("beta [rad]")






