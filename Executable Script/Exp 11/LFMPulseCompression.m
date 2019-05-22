Tp = 1e-3; % 1ms
B = 100e6; % 100MHz
c = 3e8;   % Light Speed 3x10^8 m/s
alpha = 1.2;
timeRange = 0.002;
delay = 0.001;
fs = 2*B*alpha;
gamma = B/Tp;
t = -Tp/2:1/fs:Tp/2;
s = exp(1i*pi*gamma*t.^2);
y = zeros(1, timeRange*fs);
y((delay - Tp/2)*fs:(delay + Tp/2)*fs) = s;
ty = (1:length(y))/fs;
Y = fftshift(fft(y))/length(y);
fY = linspace(-fs/2, fs/2, length(ty));
figure;
plot(ty, abs(y));
xlabel('Time(s)');
ylabel('Amplitude');
title('Echo Signal in Time Domain(Amplitude-Time)');
figure;
plot(ty, angle(y));
xlabel('Time(s)');
ylabel('Phase(rad)');
title('Echo Signal in Time Domain(Phase-Time)');
figure;
plot(fY, abs(Y));
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Echo Signal in Frequency Domain(Amplitude-Frequency)');
figure;
plot(fY, angle(Y));
xlabel('Frequency(Hz)');
ylabel('Phase(rad)');
title('Echo Signal in Frequency Domain(Phase-Frequency)');
%% Time domain signal =Flip=Conjugate=DFT=> System Function
%  Pulse Compression in frequency domain
H = fftshift(fft(ifftshift(conj(flip(s))), length(y))/length(y));
fH = linspace(-fs/2, fs/2, length(y));
figure;
plot(fH, abs(H));
xlabel('Frequency(Hz)');
ylabel('Amplitude');
title('Matched Filter in Frequency Domain(Amplitude-Frequency)');
figure;
plot(fH, angle(H));
xlabel('Frequency(Hz)');
ylabel('Phase(rad)');
title('Matched Filter in Frequency Domain(Phase-Frequency)');
C = H.*Y;
c = ifft(ifftshift(C));
figure;
plot(ty, 20*log10(abs(c)/max(abs(c))));
ylim([-50, 0]);
xlabel('Time(s)');
ylabel('Amplitude(dB)');