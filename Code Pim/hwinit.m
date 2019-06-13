%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DSCS FPGA interface board: init and I/O conversions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Ts = 0.001;

% gains and offsets
daoutoffs = [0];                   % output offset
daoutgain = 1*[-6];                   % output gain

adinoffs = -[1.1792+0.022 1.338-0.060];
adingain = [pi/(2.6063/1.00744) pi/(2.3193/0.93045)];


adinoffs = [adinoffs 0 0 0 0 0];    % input offset
adingain = [adingain 1 1 1 1 1];     % input gain (to radians)

