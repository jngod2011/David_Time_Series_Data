%% my version
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

%% getting the periodiocity information
% 1.