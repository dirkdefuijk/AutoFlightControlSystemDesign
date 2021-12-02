load('H_0.mat');
load('H_5.mat');
load('H_59.mat');
load('H_6.mat');
load('H_7.mat');
load('H_15.mat');


opt = stepDataOptions("StepAmplitude",-1);
figure
xlim([0 3])
step(H_elev_an_0,opt);
hold on;
xlim([0 3])
step(H_elev_an_5,opt);
xlim([0 3])
step(H_elev_an_59,opt);
xlim([0 3])
step(H_elev_an_6,opt);
xlim([0 3])
step(H_elev_an_7,opt);
xlim([0 3])
step(H_elev_an_15,opt);
xlim([0 3])
legend("x_a = 0","x_a = 5","x_a = 5.9","x_a = 6","x_a = 7","x_a = 15")