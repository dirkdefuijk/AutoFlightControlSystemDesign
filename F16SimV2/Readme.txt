This folder contains a model of the dynamics of an F16. The model itself is
written in C, but there is a Matlab interface such that you can easily obtain
linearized models or use Simulink to simulate the nonlinear plant.

Important files:
- F16Manual.pdf. Provides a manual for the model. The Matlab interface has
  changed a bit to make it more user-friendly (primarily FindF16Dynamics.m), but
  the information in the manual is still valid.
- nlplant.c. The non-linear model in C. To let Matlab work with this model, you
  have to 'mex' it first. This can simply be done by executing in the Matlab
  command window: mex nlplant.c
  This will create a new file (lnplant.mexw64 on Windows) and has to be done
  only once.
- FindF16Dynamics.m. A script that will trim and linearize the model at a
  condition of your choosing.
- LIN_F16Block.slx. A simulink diagram of the model, actuator dynamics and state
  integrators. This is the file that is used by FindF16Dynamics.m to linearize
  the aircraft.

