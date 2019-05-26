Tp = 1e-3;
B = 100e6;
alpha = 2;
timeRange = 2.2e-3;
delay = 0.0015;
fs = 2*B*alpha;
gamma = B/Tp;
%% Signal Length
referenceSignalLength = Tp*fs;
echoSignalLength = timeRange*fs;
pulseCompressionLength = referenceSignalLength + echoSignalLength + 1;
%% Reference Signal
ts = -Tp/2:1/fs:Tp/2;
s = exp(1i*pi*gamma*ts.^2);
figure;
subplot(2, 1, 1);
plot(ts, abs(s));
title('Reference Signal in Time Domain');
xlabel('Time(s)');
ylabel('Amplitude');
subplot(2, 1, 2);
plot(ts, angle(s));
xlabel('Time(s)');
ylabel('Phase(rad)');
%% Echo Signal
ty = 0:1/fs:timeRange;
ctp = round(delay/timeRange*echoSignalLength);
y = zeros(1, echoSignalLength + 1);
y(ctp - referenceSignalLength/2:ctp + referenceSignalLength/2) = s;
figure;
subplot(2, 1, 1);
plot(ty, abs(y));
title('Echo Signal in Time Domain');
xlabel('Time(s)');
ylabel('Amplitude');
subplot(2, 1, 2);
plot(ty, angle(y));
xlabel('Time(s)');
ylabel('Phase(rad)');
%% Reference Signal in Frequency Domain
S = fftshift(fft(ifftshift(s)));
figure;
plot(abs(S));
%% Echo Signal in Frequency Domain
ss = [zeros(1, echoSignalLength/2), s, zeros(1, echoSignalLength/2)];
Y = fftshift(fft([y, zeros(1, referenceSignalLength)]));
figure;
plot(abs(Y));
%% Matched Filter
H = fftshift(fft(flip(conj(ifftshift(ss)))));
%% Pulse Compression
C = H.*Y;
c = ifft(ifftshift(C));
tc = (1:pulseCompressionLength)/fs;
figure;
subplot(2, 1, 1);
plot(tc, abs(c));
subplot(2, 1, 2);
plot(tc, angle(c));