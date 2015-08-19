function plotFFTPSD(ts, Fs)

ts_norm = (ts-mean(ts))/std(ts);

%%%%%%%%% version 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% L = length(ts_norm);
% NFFT = 2^nextpow2(L); % Next power of 2 from length of y
% % NFFT = 128;
% 
% y = fft(ts_norm,NFFT,2);
% y = abs(y.^2); % raw power spectrum density
% f = Fs/2*linspace(0,1,NFFT/2+1);
% 
% % Plot single-sided amplitude spectrum.
% figure
% plot(f,2*y(1:NFFT/2+1)) 
% title('Single-Sided Amplitude Spectrum of y(t)')
% xlabel('Frequency (Hz)')
% ylabel('|Y(f)|')
%%%%%%%%% version 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[pxx,f] = periodogram(ts_norm,[],512,Fs); % same as using fft

plot(f,pxx);
end