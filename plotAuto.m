function plotAuto(ts,Fs)

ts_norm = (ts-mean(ts))/std(ts);
[autocor,lags] = xcorr(ts_norm,100*Fs,'coeff'); % set the maximum delay to be 60*Fs = 60days
plot(lags/Fs,autocor)

end