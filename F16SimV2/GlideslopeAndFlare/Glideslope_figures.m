sim('GlideslopeAndFlare.slx')

%% height
figure
plot(out.tout, out.h_total)
grid on
ylabel('Height [ft]')
xlabel('Time [s]')
ylim([0 2100])

%% vertical velocity
figure
plot(out.tout, out.h_dot)
grid on
ylabel('Vertical velocity [ft/s]')
xlabel('Time [s]')

%% angle error
figure
plot(out.tout, out.glideslope_angle_error)
grid on
xlim([0 60])
ylim([-2e-4 1.6e-3])
xlabel('Time [s]')
ylabel('Glideslope angle error [\circ]')

%% deviation
figure
plot(out.tout, out.glideslope_deviation)
grid on
xlim([0 60])
ylim([-0.1 1])
xlabel('Time [s]')
ylabel('Glideslope deviation [ft]')




