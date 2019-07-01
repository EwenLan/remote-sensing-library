Tp = 10e-6; % 10us
B = 100e6; % 100MHz
alpha = 6;
timeRange = 32e-6;
delay = 17e-6;
tc = 0.5*Tp;
fs = round(2*B*alpha);
gamma = B/Tp;
normalized2dB = @(x) 20*log10(abs(x)/max(abs(x)));

%% Reference Signal
referenceN = floor(Tp*fs + 1);
referenceTime = -Tp/2:1/fs:Tp/2;
referenceSignal = exp(1i*pi*gamma*referenceTime.^2);
referenceSignal_notBaseband = exp(1i*pi*gamma*(referenceTime - tc).^2);
referenceF = (-(referenceN - 1)/2:(referenceN - 1)/2)/referenceN*fs;
figure;
plot(referenceF/1e6, abs(fftshift(fft(referenceSignal))));
xlabel('Frequency (MHz)');
ylabel('Magnitude');
title('LFM Signal Spectrum');

%% Echo Signal
receivingN = timeRange*fs + 1;
receivingTime = 0:1/fs:timeRange;
receivingSignal = zeros(1, receivingN);
receivingSignal_pure = zeros(1, receivingN);
receivingDelayN = round(delay*fs - referenceN/2);
receivingSignal(receivingDelayN:receivingDelayN + referenceN - 1) = referenceSignal_notBaseband;
receivingSignal_pure(receivingDelayN:receivingDelayN + referenceN - 1) = referenceSignal;
figure;
plot(receivingTime, abs(receivingSignal));
xlabel('Time (us)');
ylabel('Magnitude');
title('Echo Signal');

%% Pulse Compression
matchedFilterN = 2^nextpow2(referenceN + receivingN - 1);
matchedFilterTime_referenceSignal = (0:matchedFilterN - 1)/fs - Tp/2;
matchedFilter_referenceSignal = exp(-1i*pi*gamma*(referenceTime + tc).^2);
matchedFilterH_referenceSignal = fft(matchedFilter_referenceSignal, matchedFilterN);
matchedFilterH_pure = fft(conj(flip(referenceSignal)), matchedFilterN);
matchedFilterOutput = ifft(matchedFilterH_referenceSignal.*fft(receivingSignal, matchedFilterN));
matchedFilterOutput_pure = ifft(matchedFilterH_pure.*fft(receivingSignal_pure, matchedFilterN));
figure;
plot(matchedFilterTime_referenceSignal*1e6, normalized2dB(matchedFilterOutput_pure), matchedFilterTime_referenceSignal*1e6, normalized2dB(matchedFilterOutput));
ylim([-60, 0]);
xlabel('Time (us)');
ylabel('Magnitude (dB)');
title('Pulse Compression');
legend({'Baseband Pulse Compression', 'Not Baseband Pulse Compression'});