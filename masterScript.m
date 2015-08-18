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

% plot(saA_day(1):saA_day(end),isaA_nphy');
% xlabel('Day in a year');
% ylabel('Relative Abundance(%)');
% print('Figures/raw TS plots/norm_cubicinterp_OTU_phy_TS_saliva_A_mine','-dtiff');
% plot(stA_day(1):stA_day(end),istA_nphy');
% xlabel('Day in a year');
% ylabel('Relative Abundance(%)');
% print('Figures/raw TS plots/norm_cubicinterp_OTU_phy_TS_stool_A_mine','-dtiff');
% plot(stB_day(1):stB_day(end),istB_nphy');
% xlabel('Day in a year');
% ylabel('Relative Abundance(%)');
% print('Figures/raw TS plots/norm_cubicinterp_OTU_phy_TS_stool_B_mine','-dtiff');


% subject A relocated to Southeast Asia between day 71 and 122

% the indices for most abundant phylums:
% saliva A: [10 17 5 2 20];
% stool A: [10 5 2 24 17];
% stool B: [5 10 24 17 26 2];
sample_name = 'saliva A';
phy_label = saA_label;
top_phys = [10 17 5 2 20];
% t_range = 26:70;
% t_range = 71:122;
% t_range = 123:364;
time_ranges = [26 70;71 122;123 364];

T = 3; %%%%% choose time region %%%%%%%%%%%%%
t_range = time_ranges(T,1):time_ranges(T,2);


%%%%%% get time series of phylums with NaNs (raw data wo interpolation)
% get the day indices for missing days
saA_day_all = saA_day(1):saA_day(end);
saA_NaN_day = setdiff(saA_day_all,saA_day)-saA_day(1)+1;

% set the days with missing values to NaN (on normalized phylum series)
saA_nphy_wNaN = isaA_nphy;
saA_nphy_wNaN(:,saA_NaN_day)=NaN;

%%%%%%%%%%%%%%  plotting raw data %%%%%%%%%%%%%%%%%%%%%
phy_index = 10;

figure
hold on
for i = top_phys
plotTimeSeries(time_ranges,saA_nphy_wNaN(i,:));
end
legend(saA_label(top_phys));
plot([time_ranges(2,1) time_ranges(2,1)],[0 0.8],'k--');
plot([time_ranges(3,1) time_ranges(3,1)],[0 0.8],'k--');
xlabel('days')
ylabel('relative abundance')
print('Figures/raw TS plots/saliva A top 5','-dtiff')


%% getting the periodiocity information


%%%%%%%%%%%%%%%%%%%% FFT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FFT on the whole time series (interpolated)
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

Fs = 1; % data were sampled once per day
figure
hold on
for i = top_phys
    ts= isaA_nphy(i,t_range-25);
    plotFFTPSD(ts,Fs);
end
ax = gca;
ax.XLim = [0 0.5];
xlabel('Frequency (cycles/day)')
ylabel('PSD')
title('FFT power spectrum')
legend(saA_label(top_phys))
% print('Figures/periodicity/FFT PSD example','-dtiff');
print(['Figures/periodicity/FFT PSD ',sample_name,' T',num2str(T)],'-dtiff');

%%%%%%%%%%%%%%%%%%%% Lomb-Scargle method %%%%%%%%%%%%%%%%%
% set the interpolated values back to NaNs
figure
hold on
for i = top_phys
    ts_wNaN= saA_nphy_wNaN(i,t_range-25);
    plotLSPSD(ts_wNaN,Fs);
end
xlabel('Frequency (day^{-1})');
ylabel('PSD')
title('Lomb-Scargle Power Spectrum')
legend(saA_label(top_phys))
print(['Figures/periodicity/Lomb-Scargle PSD ',sample_name,' T',num2str(T)],'-dtiff');

%%%%%%%%%%%%%%%%%%%% auto-correlation %%%%%%%%%%%%%%%%%%%%
figure
hold on
for i = top_phys
    plotAuto(isaA_nphy(i,t_range-25),Fs);
end
xlabel('Lag (days)')
ylabel('Autocorrelation')
legend(saA_label(top_phys))
print(['Figures/periodicity/autocorrelation ',sample_name,' T',num2str(T)],'-dtiff');

% axis([-21 21 -0.4 1.1])
