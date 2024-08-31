% QAM Order
M = 16;

% Number of symbols per SNR point
numSymbols = 1e5;

% SNR Range
SNRdb = 0 : 2 : 20;

% Convert SNR to Eb/No
EbNo = SNRdb - 10*log2(M);
numSNR = length(SNRdb);

% Initialize SER array
SER = zeros(1, numSNR);

% Receiver impairments
gainImbalance = 0.1;    % Gain Imbalace
phaseMismatch = 0.05;   % Phase Mismatch
dcOffsetI = 0.05;       % DC Offset in the I component
dcOffsetQ = 0.05;       % DC Offset in the Q component

for k = 1:numSNR
    % Generate random data symbols
    dataSymbols = randi([0 M-1], numSymbols, 1);

    % Apply QAM modulation
    modulatedSignal = qammod(dataSymbols, M, 'UnitAveragePower',true);

    % Apply gain imbalance
    I = real(modulatedSignal);
    Q = imag(modulatedSignal);
    receivedSignal = (1 + gainImbalance)*I + 1i*(1 - gainImbalance)*Q;

    % Apply phase mismatch
    receivedSignal = receivedSignal .* exp(1i * phaseMismatch);
    % Apply DC offsets
    receivedSignal = receivedSignal + dcOffsetI + 1i*dcOffsetQ;
    % Add AWGN
    receivedSignal = awgn(receivedSignal, SNRdb(k), 'measured');
    % QAM demodulation
    demodulatedSymbols = qamdemod(receivedSignal, M, 'UnitAveragePower', true);
    % Calculate symbol error rate
    SER(k) = sum(dataSymbols ~= demodulatedSymbols) / numSymbols;
end

% Plot SER vs EbNo
figure;
semilogy(EbNo, SER, 'b-o');
xlabel('Eb/No (dB)');
ylabel('Symbol Error Rate (SER)');
title('SER v/s Eb/No for 16 QAM with Receiver Impairments');
grid on;

% Display results for each SNR plot
fprintf('SNR (dB)   SER\n');
fprintf('---------  ----\n');
for k = 1:numSNR
    fprintf('%8.2f  %e\n', SNRdb(k), SER(k));
end

% Plot constellation diagram for highest SNR plot
scatterplot(receivedSignal);
title('Received Signal Constellation with Receiver Impairments (SNR = 20 dB)');
grid on;