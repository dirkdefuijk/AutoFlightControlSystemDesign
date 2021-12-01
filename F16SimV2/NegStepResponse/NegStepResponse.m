load('Trim_indiv_xa0.mat');

H_system = tf(SS_long_lo);
H_elev_to_an = H_system(6,2); % Output 6 (a_n) due to input 2 (elevator)

opt = stepDataOptions("StepAmplitude", -1);
figure
step(H_elev_to_an,opt);
xlim([0 2]);