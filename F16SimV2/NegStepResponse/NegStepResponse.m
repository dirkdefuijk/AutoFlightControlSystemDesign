load('Trim_15000_500.mat');

H_system = tf(SS_long_lo);
H_elev_to_an = H_system(6,2); % Output 6 (a_n) due to input 2 (elevator)
set(H_elev_to_an, "OutputName", "a_n");
t = 0:0.001:2;
opt = stepDataOptions("StepAmplitude", -1);
figure
step(H_elev_to_an,opt,t);
ylabel("a_n (m/s^2)")
grid on