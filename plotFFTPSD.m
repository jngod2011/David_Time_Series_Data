function plotFFTPSD(ts, Fs)
ts_norm = (ts-mean(ts))/std(ts);

[pxx,f] = periodogram(ts_norm,[],2048,Fs); % same as using fft

plot(f,pxx);
end