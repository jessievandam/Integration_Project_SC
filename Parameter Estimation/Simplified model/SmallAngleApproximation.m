%% Small angle approximation

load('Data_real_smallangle.mat')

data = theta2.data;
plot(data)

peaks = [108; 168; 226; 287; 347; 404; 463;522;582;640;701;758;819;879;936;995;1054;1114;1170;1229];
theta_peaks = data(peaks);
peaks = 0.01*peaks;

omega_d = zeros(length(peaks)-1,1);
for i = 1:length(peaks)-1
    omega_d(i) = 2*pi/(peaks(i+1)-peaks(i));
end
 
zeta = zeros(length(theta_peaks)-1,1);
for j = 1:length(theta_peaks)-1
    zeta(j) = (log(theta_peaks(j)/theta_peaks(j+1)))/(sqrt(4*pi^2+(log(theta_peaks(j)/theta_peaks(j+1)))^2));
end


omega_d_mean = mean(omega_d);
zeta_mean = mean(zeta);

omega_n = omega_d_mean/(sqrt(1-zeta_mean^2));

%I = (par.m2*par.g*par.c2)/(omega_n^2);
b = 2*zeta_mean*omega_n*par.I2;