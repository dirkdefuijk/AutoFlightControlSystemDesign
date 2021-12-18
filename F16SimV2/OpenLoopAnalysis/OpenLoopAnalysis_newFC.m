load("Trim_40000_600.mat");

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



%% SAVE MODEL W/O ACTUATOR DYNAMICS
system_reduced_long = ss(A_ac_long,B_ac_long,eye(4),zeros(4,1));
set(system_reduced_long,'StateName',["V_t" "alpha" "theta" "q"]);
set(system_reduced_long, 'InputName',["u_el"]);
set(system_reduced_long, 'OutputName', ["V_t" "alpha" "theta" "q"]);
save system_reduced_long_newFC.mat system_reduced_long

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

system_lat = ss(A_overall_lat,B_overall_lat,C_overall_lat,D_overall_lat);
set(system_lat,'StateName',["beta" "phi" "p" "r" "detla_a" "delta_r"]);
set(system_lat, 'InputName',["u_a" "u_r"]);
set(system_lat, 'OutputName', ["beta" "phi" "p" "r" "detla_a" "delta_r"]);
save system_lat.mat system_lat

%% Test
s = tf('s');
H_elev = a/(s+a);
sys_ac_long = ss(A_ac_long,B_ac_long,eye(4),0);
H_OL_long = H_elev*sys_ac_long;

H_ail = a/(s+a);
H_rud = a/(s+a);
sys_ac_lat = ss(A_ac_lat,B_ac_lat,eye(4),zeros(4,2));
H_OL_lat = H_ail*sys_ac_lat;



