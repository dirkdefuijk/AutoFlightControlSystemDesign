load("Trim_40000_300.mat");

%% LONGITUDINAL
A_OL = SS_long_lo.A(2:7,2:7); % 6x6
B_OL = SS_long_lo.B(2:7,:); % 6x2
save("A_OL_long.mat","A_OL");
save("B_OL_long.mat","B_OL");

% get A_ac
A_temp = [SS_long_lo.A(3,:);SS_long_lo.A(4,:);SS_long_lo.A(2,:);SS_long_lo.A(5,:)];
A_ac = [A_temp(:,3) A_temp(:,4) A_temp(:,2) A_temp(:,5)];

B_ac = [0;0;0;0];

a = 20.2;
A_overall = [A_ac B_ac;0 0 0 0 -a];
B_overall = [0;0;0;0;a];
C_overall = eye(5);
D_overall = 0;
system_long = ss(A_overall,B_overall,C_overall,D_overall);
save system_long.mat system_long

%% LATERAL

A_OL = SS_long_lo.A(2:7,2:7); % 6x6
B_OL = SS_long_lo.B(2:7,:); % 6x2
save("A_OL_lat.mat","A_OL");
save("B_OL_lat.mat","B_OL");

% get A_ac
A_temp = [SS_long_lo.A(3,:);SS_long_lo.A(4,:);SS_long_lo.A(2,:);SS_long_lo.A(5,:)];
A_ac = [A_temp(:,3) A_temp(:,4) A_temp(:,2) A_temp(:,5)];

B_ac = [0;0;0;0];





