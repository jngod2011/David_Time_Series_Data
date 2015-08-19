function plotFFTPhase(ts,Fs)

ts_norm = (ts-mean(ts))/std(ts);
NFFT = 512;
Y = fft(ts_norm,NFFT,2);

F = ((0:1/NFFT:1-1/NFFT)*Fs).';
% magnitudeY = abs(Y);        % Magnitude of the FFT
phaseY = unwrap(angle(Y));  % Phase of the FFT

plot(F(1:NFFT/2),phaseY(1:NFFT/2));

end