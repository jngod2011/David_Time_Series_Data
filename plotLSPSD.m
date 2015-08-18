function plotLSPSD(ts_wNaN,Fs)

Fmax = Fs/2;

ts_norm_wNaN = (ts_wNaN-nanmean(ts_wNaN))/nanstd(ts_wNaN);

[pxx_wNaN,f_wNaN] = plomb(ts_norm_wNaN,Fs,Fmax,'power');

plot(f_wNaN,pxx_wNaN);

end