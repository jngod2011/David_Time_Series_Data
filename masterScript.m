clear;clc;close;
%% Preprocessing 
% %%%%%% their version %%%%%%%%%%%%%%%%%%%%%%%
% load('DATA.mat');
% % isaA_otu=interpotu(saA_day,saA_otu(1:100,:));
% isaA_otu=interpotu(saA_day,saA_otu);
% isaA_notu=normotu(isaA_otu);
% % istA_otu=interpotu(stA_day,stA_otu(1:100,:));
% istA_otu=interpotu(stA_day,stA_otu);
% istA_notu=normotu(istA_otu);
% % istB_otu=interpotu(stB_day,stB_otu(1:100,:));
% istB_otu=interpotu(stB_day,stB_otu);
% istB_notu=normotu(istB_otu);
% [isaA_phy,saA_label]=phylumotu(isaA_notu,OTU_label);
% [istA_phy,stA_label]=phylumotu(istA_notu,OTU_label);
% [istB_phy,stB_label]=phylumotu(istB_notu,OTU_label);
% 
% plot(isaA_phy');
% print('Figures/raw TS plots/norm_interp_OTU_phy_TS_saliva_A_stu','-dtiff');
% plot(istA_phy');
% print('Figures/raw TS plots/norm_interp_OTU_phy_TS_stool_A_stu','-dtiff');
% plot(istB_phy');
% print('Figures/raw TS plots/norm_interp_OTU_phy_TS_stool_B_stu','-dtiff');

%%%%%% my version %%%%%%%%%%%%%%%%%%%%%%%%%%
load('DATA.mat');
% 1. combine the absolute abundance together
[saA_phy,saA_label]=phylumotu(saA_otu,OTU_label);
[stA_phy,stA_label]=phylumotu(stA_otu,OTU_label);
[stB_phy,stB_label]=phylumotu(stB_otu,OTU_label);
% 2. interpolation for the days with missing values
isaA_phy=interpotu(saA_day,saA_phy);
istA_phy=interpotu(stA_day,stA_phy);
istB_phy=interpotu(stB_day,stB_phy);
% 3. normalization for each day to get relative abundance
isaA_nphy=normotu(isaA_phy);
istA_nphy=normotu(istA_phy);
istB_nphy=normotu(istB_phy);

plot(saA_day(1):saA_day(end),isaA_nphy');
xlabel('Day in a year');
ylabel('Relative Abundance(%)');
print('Figures/raw TS plots/norm_cubicinterp_OTU_phy_TS_saliva_A_mine','-dtiff');
plot(stA_day(1):stA_day(end),istA_nphy');
xlabel('Day in a year');
ylabel('Relative Abundance(%)');
print('Figures/raw TS plots/norm_cubicinterp_OTU_phy_TS_stool_A_mine','-dtiff');
plot(stB_day(1):stB_day(end),istB_nphy');
xlabel('Day in a year');
ylabel('Relative Abundance(%)');
print('Figures/raw TS plots/norm_cubicinterp_OTU_phy_TS_stool_B_mine','-dtiff');

%% getting the periodiocity information

% subject A relocated to Southeast Asia between day 71 and 122
% ts= isaA_nphy(10,1:70-25);
% ts= isaA_nphy(10,71-25:122-25);
ts= isaA_nphy(10,123-25:364-25);
ts_norm = ts-mean(ts);
Fs = 1; % data were sampled once per day

%%%%%%%%%%%%%%%%%%%% FFT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FFT on the whole time series (interpolated)
%%%%%%%%% version 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
% NFFT = 128;

y = fft(ts_norm,NFFT,2);
y = abs(y.^2); % raw power spectrum density
L = length(ts_norm);
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure
plot(f,2*y(1:NFFT/2+1)) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
%%%%%%%%% version 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[pxx,f] = periodogram(ts_norm,[],[],Fs); % same as using fft
figure
plot(f,pxx)
ax = gca;
ax.XLim = [0 0.5];
xlabel('Frequency (cycles/day)')
ylabel('Magnitude')
%%%%%%%%%%%%%%%%%%%% auto-correlation %%%%%%%%%%%%%%%%%%%%
[autocor,lags] = xcorr(ts_norm,60*Fs,'coeff');
figure
plot(lags/Fs,autocor)
xlabel('Lag (days)')
ylabel('Autocorrelation')
% axis([-21 21 -0.4 1.1])


%%%%%%%%%%%%%%%%%%%% Lomb-Scargle method %%%%%%%%%%%%%%%%%
% set the interpolated values back to NaNs
