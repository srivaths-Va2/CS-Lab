%% Experiment 6

% For M-PSK

M_values = [2, 4, 8, 16, 32];
Eb_N0_dB = 0 : 20;
Eb_N0 = 10.^(Eb_N0_dB / 10);
ps_mpsk = zeros(length(M_values), length(Eb_N0));

for i = 1:length(M_values)
    M = M_values(i);
    pe_mpsk = qfunc(sqrt(2 * Eb_N0 * sin(pi/M)^2));
    ps_mpsk(i, :) = 1 - (1 - pe_mpsk) .^ log2(M);
end

% Plotting
figure;
semilogy(Eb_N0_dB, ps_mpsk, '-o');
grid on;
xlabel('Eb/No (dB)');
ylabel('Probability of Symbol Error');
title('Probability of Symbol Error of MPSK');
legend('M=2', 'M=4', 'M=8', 'M=16', 'M=32');

% For M-PAM
M_values = [2, 4, 8, 16, 32];
Eb_N0_dB = 0:20;
Eb_N0 = 10 .^ (Eb_N0_dB / 10);
ps_mpam = zeros(length(M_values), length(Eb_N0));

for i = 1:length(M_values)
    M = M_values(i);
    pe_mpam = qfunc(sqrt(3 * log2(M) * Eb_N0 / (M^2 - 1)));
    ps_mpam(i, :) = 1 - (1 - pe_mpam) .^ log2(M);
end

% Plotting
figure;
semilogy(Eb_N0_dB, ps_mpam, '-o');
grid on;
xlabel('Eb/No (dB)');
ylabel('Probability of symbol error');
title('Probability of Symbol Error of MPAM');
legend('M=2', 'M=4', 'M=8', 'M=16', 'M=32');

% For MQAM
M_values = [2, 4, 8, 16, 32];
Eb_N0_dB = 0:20;
Eb_N0 = 10 .^ (Eb_N0_dB / 10);
ps_mqam = zeros(length(M_values), length(Eb_N0));

for i = 1:length(M_values)
    M = M_values(i);
    pe_mqam = 2 * (1 - 1/sqrt(M)) * qfunc(sqrt(3 * log2(M) * Eb_N0 / (2 * (M - 1))));
    ps_mqam(i, :) = 1 - (1 - pe_mqam) .^ log2(M);
end

% Plotting
figure;
semilogy(Eb_N0_dB, ps_mqam, '-o');
grid on;
xlabel('Eb/No (dB)');
ylabel('Probability of Symbol Error');
title('Probability of Symbol Error Rate for MQAM');
legend('M=2', 'M=4', 'M=8', 'M=16', 'M=32');


% For FSK
M_values = [2, 4, 8 16, 32];
Eb_N0_dB = 0 : 20;
Eb_N0 = 10 .^ (Eb_N0_dB / 10);
ps_mfsk = zeros(length(M_values), length(Eb_N0));

for i = 1:length(M_values)
    M = M_values(i);
    ps_mfsk(i, :) = 2 * qfunc(sqrt((6 * log2(M)) / (M^2 - 1) * Eb_N0));
end

figure;
semilogy(Eb_N0_dB, ps_mfsk, '-o');
grid on;
xlabel('Eb/No (dB)');
ylabel('Probability of Symbol Error');
title('Probability of Symbol Error Rate for MFSK');
legend('M=2', 'M=4', 'M=8', 'M=16', 'M=32');

% For FSK-Non Coherent
M_values = [2, 4, 8, 16, 32];
Eb_N0_dB = 0 : 20;
Eb_N0 = 10 .^ (Eb_N0_dB / 10);
ps_mfsk_noncoherent = zeros(length(M_values), length(Eb_N0));

for i = 1:length(M_values)
    M = M_values(i);
    ps_mfsk_noncoherent = 2 * qfunc(sqrt((3 * log2(M))) / (2 * (M^2 - 1)) * Eb_N0);
end

% Plotting
figure;
semilogy(Eb_N0_dB, ps_mfsk_noncoherent, '-o');
grid on;
xlabel('Eb/N0 (dB)');
ylabel('Probability of Symbol Error');
title('Probability of Symbol Error of MFSK Non-Coherent');

