%% Preprocessing 
%%%%%% their version %%%%%%%%%%%%%%%%%%%%%%%
% isaA_otu=interpotu(saA_day,saA_otu(1:100,:));
isaA_otu=interpotu(saA_day,saA_otu);
isaA_notu=normotu(isaA_otu);
% istA_otu=interpotu(stA_day,stA_otu(1:100,:));
istA_otu=interpotu(stA_day,stA_otu);
istA_notu=normotu(istA_otu);
% istB_otu=interpotu(stB_day,stB_otu(1:100,:));
istB_otu=interpotu(stB_day,stB_otu);
istB_notu=normotu(istB_otu);
[isaA_phy,saA_label]=phylumotu(isaA_notu,OTU_label);
[istA_phy,stA_label]=phylumotu(istA_notu,OTU_label);
[istB_phy,stB_label]=phylumotu(istB_notu,OTU_label);

plot(isaA_phy');
print('Figures/raw TS plots/norm_interp_OTU_phy_TS_saliva_A_stu','-dtiff');
plot(istA_phy');
print('Figures/raw TS plots/norm_interp_OTU_phy_TS_stool_A_stu','-dtiff');
plot(istB_phy');
print('Figures/raw TS plots/norm_interp_OTU_phy_TS_stool_B_stu','-dtiff');
%%%%%% my version %%%%%%%%%%%%%%%%%%%%%%%%%%
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

plot(isaA_nphy');
print('Figures/raw TS plots/norm_interp_OTU_phy_TS_saliva_A_mine','-dtiff');
plot(istA_nphy');
print('Figures/raw TS plots/norm_interp_OTU_phy_TS_stool_A_mine','-dtiff');
plot(istB_nphy');
print('Figures/raw TS plots/norm_interp_OTU_phy_TS_stool_B_mine','-dtiff');

%% getting the periodiocity information
% 1. FFT on the whole time series (interpolated)
fft(