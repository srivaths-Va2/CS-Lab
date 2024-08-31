%% EXPERIMENT 7 (FHSS)

numBits = 20;
numHops = 6;
hopFrequencies = [1, 2, 3, 4, 5, 6] * 1e3;
hopDuration = 1e-3;

snr = 10;
fs = 20e3;

dataBits = randi([0 1], numBits, 1);

modulatedData = 2*dataBits - 1;
bpskSignal = repelem(modulatedData, hopDuration * fs);

t = (0 : 1/fs : hopDuration - 1/fs);
fhssSignal = [];
hopSignal = [];

for i = 1:numBits
    hopIdx = mod(i-1, numHops) + 1;
    freq = hopFrequencies(hopIdx);
    carrier = cos(2 * pi * freq * t);
    hopSignal = [hopSignal; carrier];
    fhssSignal = [fhssSignal; bpskSignal((i - 1) * length(t) + 1 : i * length(t)) .* carrier];
end

receivedSignal = awgn(fhssSignal, snr, 'measured');

demodulatedSignal = [];

receivedBits = zeros(numBits, 1);
for i = 1:numBits
    hopIdx = mod(i - 1, numHops) + 1;
    freq = hopFrequencies(hopIdx);
    carrier = cos(2 * pi * freq * t);
    segment = receivedSignal((i - 1) * length(t) + 1 : i * length(t));
    demodulated = segment .* carrier;
    demodulatedSignal = [demodulatedSignal; demodulated];
    receivedBits(i) = sum(demodulated) > 0;
end

% Plotting
figure;

% Original 20 bit sequence
subplot(3, 2, 1);
stem(dataBits, 'filled');
title('Original 20 bit sequence');
xlabel('Bit Index');
ylabel('Bit Value');
grid on;

% BPSK modulated signal
subplot(3, 2, 2);
stem(bpskSignal);
title('Spread signal with 6 frequencies');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% Spread signal with 6 frequencies
subplot(3, 2, 3);
plot(hopSignal);
title('Spread signal with 6 frequencies');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% frequency hopped spread spectrum signal at transmitter
subplot(3, 2, 4);
plot(fhssSignal);
title('Frequency Hopped Spread Spectrum Signal');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% Demodulated BPSK Signal from widespread signal
subplot(3, 2, 5);
plot(demodulatedSignal);
title('Demodulated BPSK signal from spread signal');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

% Original transmitted bits at the receiver
subplot(3, 2, 6);
stem(receivedBits, 'filled');
title('Original transmitted bits at the receiver');
xlabel('Bit Index');
ylabel('Bit Value');
grid on;

% Calculate and display BER
BER_fhss = sum(dataBits ~= receivedBits) / numBits;
fprintf('FHSS BER : %e\n', BER_fhss);
