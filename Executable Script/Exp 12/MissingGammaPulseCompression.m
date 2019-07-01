Tp = 10e-6; % 10us
B = 100e6; % 100MHz
alpha = 6;
timeRange = 32e-6;
delay = 17e-6;
fs = round(2*B*alpha);
gamma = B/Tp;
normalized2dB = @(x) 20*log10(abs(x)/max(abs(x)));

%% Reference Signal
referenceN = floor(Tp*fs + 1);
referenceTime = -Tp/2:1/fs:Tp/2;
referenceSignal = exp(1i*pi*gamma*referenceTime.^2);
referenceSignal_missingGamma = exp(1i*pi*gamma*referenceTime.^2);
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
receivingDelayN = round(delay*fs - referenceN/2);
receivingSignal(receivingDelayN:receivingDelayN + referenceN - 1) = referenceSignal_missingGamma;
figure;
plot(receivingTime, abs(receivingSignal));
xlabel('Time (us)');
ylabel('Magnitude');
title('Echo Signal');

%% Pulse Compression
matchedFilterN = 2^nextpow2(referenceN + receivingN - 1);
matchedFilterTime_referenceSignal = (0:matchedFilterN - 1)/fs - Tp/2;
matchedFilter_referenceSignal = conj(flip(referenceSignal));
matchedFilterH_referenceSignal = fft(matchedFilter_referenceSignal, matchedFilterN);
matchedFilterOutput_referenceSignal = ifft(matchedFilterH_referenceSignal.*fft(receivingSignal, matchedFilterN));
matchedFilterM_referenceSignal = conj(flip(referenceSignal.*hamming(referenceN)'));
matchedFilterWindowedH_referenceSignal = fft(matchedFilterWindowed_referenceSignal, matchedFilterN);
matchedFilterWindowedOutput_referenceSignal = ifft(matchedFilterWindowedH_referenceSignal.*fft(receivingSignal, matchedFilterN));
figure;
plot(matchedFilterTime_referenceSignal*1e6, normalized2dB(matchedFilterOutput_referenceSignal), matchedFilterTime_referenceSignal*1e6, normalized2dB(matchedFilterWindowedOutput_referenceSignal));
ylim([-60, 0]);
xlabel('Time (us)');
ylabel('Magnitude (dB)');
title('Pulse Compression');