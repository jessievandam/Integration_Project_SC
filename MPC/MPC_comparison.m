%% Make plots 

%% Sine, initial
load('meas_sim_sine_init')

theta_sim_sine_init = theta_sim;
control_sim_sine_init = controlinput;
reference_sin_sine_init = reference;


figure; hold on; grid on
plot(theta_sim_sine_init.time,theta_sim_sine_init.data(:,1))
plot(theta_sim_sine_init.time,theta_sim_sine_init.data(:,2))
plot(reference.time,reference.data,'k--')
legend('\theta_1','\theta_2','Reference for \theta_1')
ylabel('Angle [Rad]')
xlabel('Time [s]')
hold off

figure; hold on; grid on
plot(controlinput.time, controlinput.data,'r')
xlabel('Time [s]')
ylabel('Input voltage')
hold off

rms_sine_init = rms(theta_sim_sine_init.data(:,1)-reference_sin_sine_init.data);
mean_sine_th2_init = mean(theta_sim_sine_init.data(:,2));

%% Square, initial
load('meas_sim_square_init')
theta_sim_square_init = theta_sim;
control_sim_square_init = controlinput;
reference_sim_square_init = reference;

figure; hold on; grid on
plot(theta_sim_square_init.time,theta_sim_square_init.data(:,1))
plot(theta_sim_square_init.time,theta_sim_square_init.data(:,2))
plot(reference_sim_square_init.time,reference_sim_square_init.data,'k--')
legend('\theta_1','\theta_2','Reference for \theta_1','Location','SouthEast')
ylabel('Angle [Rad]')
xlabel('Time [s]')
hold off

figure; hold on; grid on
plot(control_sim_square_init.time, control_sim_square_init.data,'r')
xlabel('Time [s]')
ylabel('Control input')
hold off

rms_square_init = rms(theta_sim_square_init.data(:,1)-reference_sim_square_init.data);
mean_square_th2_init = mean(theta_sim_square_init.data(:,2));

%% Pulses, initial

load('meas_sim_pulse_init')

theta_sim_pulse_init = theta_sim;
control_sim_pulse_init = controlinput;
input_sim_pulse_init = Input;

figure; hold on; grid on;
plot(theta_sim_pulse_init.time,theta_sim_pulse_init.data(:,1))
plot(theta_sim_pulse_init.time, theta_sim_pulse_init.data(:,2))
plot(Input.time,Input.data,'k--')
legend('\theta_1','\theta_2','Disturbance input','Location','SouthEast')
ylabel('Angle [Rad]')
xlabel('Time [s]')
ylim([-1 1])
hold off


figure; hold on; grid on
plot(controlinput.time, controlinput.data,'r')
plot(Input.time,Input.data,'k--')
legend('Control input','Disturbance input','Location','SouthEast')
xlabel('Time [s]')
ylabel('Input voltage')
hold off

%% Sine, final

load('meas_sim_sine_final')

theta_sim_sine_final = theta_sim;
control_sim_sine_final = controlinput;
reference_sin_sine_final = reference;


figure; hold on; grid on
plot(theta_sim_sine_final.time,theta_sim_sine_final.data(:,1))
plot(theta_sim_sine_final.time,theta_sim_sine_final.data(:,2))
plot(reference_sin_sine_final.time,reference_sin_sine_final.data,'k--')
legend('\theta_1','\theta_2','Reference for \theta_1')
ylabel('Angle [Rad]')
xlabel('Time [s]')
hold off

figure; hold on; grid on
plot(control_sim_sine_final.time, control_sim_sine_final.data,'r')
xlabel('Time [s]')
ylabel('Input voltage')
hold off

rms_sine_final = rms(theta_sim_sine_final.data(:,1)-reference_sin_sine_final.data);
mean_sine_th2_final = mean(theta_sim_sine_final.data(:,2));

%% Square, final
load('meas_sim_square_final')
theta_sim_square_final = theta_sim;
control_sim_square_final = controlinput;
reference_sim_square_final = reference;

figure; hold on; grid on
plot(theta_sim_square_final.time,theta_sim_square_final.data(:,1))
plot(theta_sim_square_final.time,theta_sim_square_final.data(:,2))
plot(reference_sim_square_final.time,reference_sim_square_final.data,'k--')
legend('\theta_1','\theta_2','Reference for \theta_1','Location','SouthEast')
ylabel('Angle [Rad]')
xlabel('Time [s]')
hold off

figure; hold on; grid on
plot(control_sim_square_final.time, control_sim_square_final.data,'r')
xlabel('Time [s]')
ylabel('Input voltage')
hold off

rms_square_final = rms(theta_sim_square_final.data(:,1)-reference_sim_square_final.data);
mean_square_th2_final = mean(theta_sim_square_final.data(:,2));


%% Pulses, final

load('meas_sim_pulse_final')

theta_sim_pulse_final = theta_sim;
control_sim_pulse_final = controlinput;
input_sim_pulse_final = Input;

figure; hold on; grid on;
plot(theta_sim_pulse_final.time,theta_sim_pulse_final.data(:,1))
plot(theta_sim_pulse_final.time, theta_sim_pulse_final.data(:,2))
plot(Input.time,Input.data,'k--')
legend('\theta_1','\theta_2','Disturbance input','Location','SouthEast')
ylabel('Angle [Rad]')
xlabel('Time [s]')
ylim([-1 1])
hold off

% figure; hold on; grid on;
% plot(theta_sim_pulse_final.time, theta_sim_pulse_final.data(:,2))
% plot(Input.time,Input.data,'k--')
% legend('\theta_2','Disturbance input')
% ylabel('Angle [Rad]')
% xlabel('Time [s]')
% ylim([-1 1])
% hold off

figure; hold on; grid on
plot(controlinput.time, controlinput.data,'r')
plot(Input.time,Input.data,'k--')
legend('Control input','Disturbance input','Location','SouthEast')
xlabel('Time [s]')
ylabel('Input voltage')
hold off

%% Load steady state
load('meas_steadystate_final')
theta2_steadystate = theta2.data;
control = Input.data;

figure; hold on; grid on
plot(theta2.time(1:1500),theta2_steadystate(1:1500))
plot(theta2.time(1:1500),zeros(1500,1),'k--')
legend('\theta_2')
xlabel('Time [s]')
ylabel('Angle [rad]')
hold off

figure; hold on; grid on
plot(theta2.time(1:1500),control(1:1500),'r')
xlabel('Time [s]')
ylabel('Input [V]')

mean_th1 = mean(theta1);
std_th1 = std(theta1);
var_th1 = var(theta1);


mean_th2 = mean(theta2.data(1:1500));
std_th2 = std(theta2);
var_th2 = var(theta2);


%% Calculate RMS of square and sine, increased prediction horizon and control horizon

load('meas_sim_square_predcont')

theta_sim_square_predcont = theta_sim;
control_sim_square_predcont = controlinput;
reference_sim_square_predcont = reference;

rms_square_predcont = rms(theta_sim_square_predcont.data(:,1)-reference.data);

load('meas_sim_sine_predcont')

theta_sim_sine_predcont = theta_sim;
control_sim_sine_predcont = controlinput;
reference_sim_sine_predcont = reference;

rms_sine_predcont = rms(theta_sim_sine_predcont.data(:,1)-reference.data);

%% True, square input

load('meas_true_square_final')

theta1_true_square_final = theta1.data;
theta2_true_square_final = theta2.data;
input_true_square_final = Input.data;
reference_true_square_final = Reference.data;

figure; hold on; grid on;
plot(theta1.time,theta1_true_square_final)
plot(theta2.time, theta2_true_square_final)
plot(Reference.time, reference_true_square_final,'k--')
legend('\theta_1','\theta_2','Reference signal')
xlabel('Time [s]')
ylabel('Angle [rad]')
hold off

figure; hold on; grid on;
plot(Input.time, input_true_square_final,'r')
xlabel('Time [s]')
ylabel('Input [V]')

rms_true_square = rms(reference_true_square_final-theta1_true_square_final);
std_true_square = std(theta1_true_square_final);

%% True, sine input
load('meas_true_sine_final')

theta1_true_sine_final = theta1.data;
theta2_true_sine_final = theta2.data;
input_true_sine_final = Input.data;
reference_true_sine_final = Reference.data;

figure; hold on; grid on;
plot(theta1.time,theta1_true_sine_final)
plot(theta2.time, theta2_true_sine_final)
plot(Reference.time, reference_true_sine_final,'k--')
legend('\theta_1','\theta_2','Reference signal')
xlabel('Time [s]')
ylabel('Angle [rad]')
hold off

figure; hold on; grid on;
plot(Input.time, input_true_sine_final,'r')
xlabel('Time [s]')
ylabel('Input [V]')

rms_true_sine = rms(reference_true_sine_final-theta1_true_sine_final);
std_true_sine = std(theta1_true_sine_final);

%% True, disturbance rejection
load('meas_true_pulse_final')

theta1_true_pulse_final = theta1;
theta2_true_pulse_final = theta2;
input_true_pulse_final = Pulses.data;
reference_true_pulse_final = Reference.data;

figure; hold on; grid on;
plot(theta1_true_pulse_final.time,theta1_true_pulse_final.data)
plot(theta2_true_pulse_final.time, theta2_true_pulse_final.data)
plot(Pulses.time,Pulses.data,'k--')
legend('\theta_1','\theta_2','Disturbance input','Location','SouthEast')
ylabel('Angle [Rad]')
xlabel('Time [s]')
ylim([-0.7 0.9])
hold off

figure; hold on; grid on
plot(controlinput.time, controlinput.data,'r')
plot(Pulses.time,Pulses.data,'k--')
legend('Control input','Disturbance input','Location','SouthEast')
xlabel('Time [s]')
ylabel('Input voltage')
ylim([-1.1 1.1])
hold off
