Tp = 10e-6; % 10us
B = 100e6; % 100MHz
alpha = 1.2;
timeRange = 32e-6;
delay = 17e-6;
fs = round(2*B*alpha);
gamma = B/Tp;
normalized2dB = @(x) 20*log10(abs(x)/max(abs(x)));

%% Reference Signal
referenceN = Tp*fs + 1;
referenceTime = -Tp/2:1/fs:Tp/2;
referenceSignal = exp(1i*pi*gamma*referenceTime.^2);
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
receivingSignal(receivingDelayN:receivingDelayN + referenceN - 1) = referenceSignal;
figure;
plot(receivingTime, abs(receivingSignal));
xlabel('Time (us)');
ylabel('Magnitude');
title('Echo Signal');

%% Pulse Compression
% Frequency Domain
% Reference Signal - Time Domain Filping and Conjugating-> Matched Filter
matchedFilterN = 2^nextpow2(referenceN + receivingN - 1);
matchedFilterTime_referenceSignal = (0:matchedFilterN - 1)/fs - Tp/2;
matchedFilter_referenceSignal = conj(flip(referenceSignal));
matchedFilterH_referenceSignal = fft(matchedFilter_referenceSignal, matchedFilterN);
matchedFilterOutput_referenceSignal = ifft(matchedFilterH_referenceSignal.*fft(receivingSignal, matchedFilterN));
figure;
plot(matchedFilterTime_referenceSignal*1e6, normalized2dB(matchedFilterOutput_referenceSignal));
xlabel('Time (us)');
ylabel('Magnitude (dB)');
title('Pulse Compression');
% Reference Signal - Frequency Domain Conjugating -> Matched Filter
matchedFilterTime_referenceSignal2 = (0:matchedFilterN - 1)/fs + Tp/2;
matchedFilterH_referenceSignal2 = conj(fft(referenceSignal, matchedFilterN));
matchedFilterOutput_referenceSignal2 = ifft(matchedFilterH_referenceSignal2.*fft(receivingSignal, matchedFilterN));
figure;
plot(matchedFilterTime_referenceSignal2*1e6, normalized2dB(matchedFilterOutput_referenceSignal2));
xlabel('Time (us)');
ylabel('Magnitude (dB)');
title('Pulse Compression');
% Frequency Domain Generation
deltaF = fs/matchedFilterN;
matchedFilterF = (-matchedFilterN/2:(matchedFilterN/2 - 1))/matchedFilterN*fs;
matchedFilterF_frequencyGeneration = -B/2:deltaF:B/2;
matchedFilterN_frequecnyGeneration = length(matchedFilterF_frequencyGeneration);
matchedFilterH_frequencyGeneration = zeros(1, matchedFilterN);
matchedFilterH_frequencyGeneration(1, matchedFilterN/2 - (matchedFilterN_frequecnyGeneration - 1)/2:matchedFilterN/2 + (matchedFilterN_frequecnyGeneration - 1)/2) = exp(1i*pi/gamma*matchedFilterF_frequencyGeneration.^2);
matchedFilterOutput_frequencyGeneration = ifft(ifftshift(matchedFilterH_frequencyGeneration).*fft(receivingSignal, matchedFilterN));
figure;
plot(matchedFilterTime_referenceSignal2*1e6, normalized2dB(matchedFilterOutput_frequencyGeneration));
xlabel('Time (us)');
ylabel('Magnitude (dB)');
title('Pulse Compression');
% Time Domain
% Linear Convolution
linearConvolutionTime = (-(referenceN - 3)/2:((referenceN - 1)/2 + receivingN))/fs;
linearConvolutionOutput = conv(conj(referenceSignal), receivingSignal);
figure;
plot(linearConvolutionTime*1e6, normalized2dB(linearConvolutionOutput));
xlabel('Time (us)');
ylabel('Magnitude (dB)');
title('Pulse Compression');