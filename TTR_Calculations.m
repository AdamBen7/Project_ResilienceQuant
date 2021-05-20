%%
clear;clc;
[full, full_text, ~]=  xlsread('Calculations Apparel Industry.xlsx','Stock Prices');
%[full, full_text, ~]=  xlsread('Calculations Apparel Industry.xlsx','Market Cap to Revenues');

Stock_ADS = full(:,1);
Stock_MONC = full(:,2);
Stock_HBI = full(:,3);
Stock_PUM = full(:,4);
Stock_UAA = full(:,5);
Stock_BRBY = full(:,6);
Stock_NKE = full(:,7);
Stock_GIL = full(:,8);
Stock_VFC = full(:,9);
Stock_AVG = full(:,10);

x_ticks = full_text(2:end,1)

proportion_label = length(x_ticks)/10;
count =1;
for i = 1:proportion_label:length(x_ticks)
    the_xticks_ind(count) = floor(i);
    the_xticks(count) = x_ticks(floor(i));
    count = count + 1;
end
if floor(proportion_label) ~= proportion_label
    the_xticks_ind(count) = length(x_ticks);
    the_xticks(count) = x_ticks(the_xticks_ind(count));  
end
clear count x_ticks;


%%
Fltr = 30; %#min. # of days for TTR

Test_NKE = Stock_NKE(1:100);

NKE_Peak = TTR_Calc(Test_NKE,1,1,Fltr);
%%
the_x = 1:length(Test_NKE);
figure(1)
hold on
grid on
legend on
plot(Test_NKE)
scatter(NKE_Peak(1,:), NKE_Peak(2,:), '*g')
scatter(NKE_Peak(4,:), NKE_Peak(5,:), 'xr')
%xlim([the_xticks_ind(1) the_xticks_ind(end)]);
xticks(the_xticks_ind) %the_x
xticklabels(the_xticks) %x_tick
xtickangle(45)
legend('data','peaks ','lows')
hold off
%%
NKE_Peak = TTR_Calc(Stock_NKE,1,1,Fltr);
ADS_Peak = TTR_Calc(Stock_ADS,1,1,Fltr);
PUM_Peak = TTR_Calc(Stock_PUM,1,1,Fltr);
UAA_Peak = TTR_Calc(Stock_UAA,1,1,Fltr);
BRBY_Peak = TTR_Calc(Stock_BRBY,1,1,Fltr);
GIL_Peak = TTR_Calc(Stock_GIL,1,1,Fltr);
HBI_Peak = TTR_Calc(Stock_HBI,1,1,Fltr);
MONC_Peak = TTR_Calc(Stock_MONC,1,1,Fltr);
VFC_Peak = TTR_Calc(Stock_VFC,1,1,Fltr);
AVG_Peak = TTR_Calc(Stock_AVG,1,1,Fltr);

%%
%use mean and also look at max.
NKE_TTR = mean(NKE_Peak(3,:));
NKE_Mag = mean(NKE_Peak(2,:)- NKE_Peak(5,:));
ADS_TTR = mean(ADS_Peak(3,:));
ADS_Mag = mean(ADS_Peak(2,:)- ADS_Peak(5,:));
PUM_TTR = mean(PUM_Peak(3,:));
PUM_Mag = mean(PUM_Peak(2,:)- PUM_Peak(5,:));
UAA_TTR = mean(UAA_Peak(3,:));
UAA_Mag = mean(UAA_Peak(2,:)- UAA_Peak(5,:));
BRBY_TTR = mean(BRBY_Peak(3,:));
BRBY_Mag = mean(BRBY_Peak(2,:)- BRBY_Peak(5,:));
GIL_TTR = mean(GIL_Peak(3,:));
GIL_Mag = mean(GIL_Peak(2,:)- GIL_Peak(5,:));
HBI_TTR = mean(HBI_Peak(3,:));
HBI_Mag = mean(HBI_Peak(2,:)- HBI_Peak(5,:));
MONC_TTR = mean(MONC_Peak(3,:));
MONC_Mag = mean(MONC_Peak(2,:)- MONC_Peak(5,:));
VFC_TTR = mean(VFC_Peak(3,:));
VFC_Mag = mean(VFC_Peak(2,:)- VFC_Peak(5,:));
AVG_TTR = mean(AVG_Peak(3,:));
AVG_Mag = mean(AVG_Peak(2,:)- AVG_Peak(5,:));


clc;
fprintf('Nike: Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',NKE_TTR, NKE_Mag)
fprintf('Adds: Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',ADS_TTR, ADS_Mag)
fprintf('PUMA: Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',PUM_TTR, PUM_Mag)
fprintf('UAA : Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',UAA_TTR, UAA_Mag)
fprintf('BRBY: Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',BRBY_TTR, BRBY_Mag)
fprintf('GIL : Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',GIL_TTR, GIL_Mag)
fprintf('HBI : Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',HBI_TTR, HBI_Mag)
fprintf('MONC: Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',MONC_TTR, MONC_Mag)
fprintf('VFC : Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',VFC_TTR, VFC_Mag)
fprintf('AVG : Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',AVG_TTR, AVG_Mag)

NKE_PtoT_Ratio = mean(NKE_Peak(6,:));
ADS_PtoT_Ratio = mean(ADS_Peak(6,:));
PUM_PtoT_Ratio = mean(PUM_Peak(6,:));
UAA_PtoT_Ratio = mean(UAA_Peak(6,:));
BRBY_PtoT_Ratio = mean(BRBY_Peak(6,:));
GIL_PtoT_Ratio = mean(GIL_Peak(6,:));
HBI_PtoT_Ratio = mean(HBI_Peak(6,:));
MONC_PtoT_Ratio = mean(MONC_Peak(6,:));
VFC_PtoT_Ratio = mean(VFC_Peak(6,:));
AVG_PtoT_Ratio = mean(AVG_Peak(6,:));

data_matrix = [ ADS_TTR, ADS_Mag, ADS_PtoT_Ratio, max(ADS_Peak(6,:));
                BRBY_TTR, BRBY_Mag, BRBY_PtoT_Ratio, max(BRBY_Peak(6,:));
                GIL_TTR, GIL_Mag, GIL_PtoT_Ratio, max(GIL_Peak(6,:));
                HBI_TTR, HBI_Mag, HBI_PtoT_Ratio, max(HBI_Peak(6,:));
                MONC_TTR, MONC_Mag, MONC_PtoT_Ratio, max(MONC_Peak(6,:));
                NKE_TTR, NKE_Mag, NKE_PtoT_Ratio, max(NKE_Peak(6,:));
                PUM_TTR, PUM_Mag, PUM_PtoT_Ratio, max(PUM_Peak(6,:));
                UAA_TTR, UAA_Mag, UAA_PtoT_Ratio, max(UAA_Peak(6,:));
                VFC_TTR, VFC_Mag, VFC_PtoT_Ratio, max(VFC_Peak(6,:));
                AVG_TTR, AVG_Mag,AVG_PtoT_Ratio, max(AVG_Peak(6,:))];
writematrix(data_matrix,'test.csv');
%%
histogram(PUM_Peak(3,:),10)
%%
figure(1)
hold on
grid on
legend on
plot(Stock_PUM)
scatter(PUM_Peak(1,:), PUM_Peak(2,:), '*g')
scatter(PUM_Peak(4,:), PUM_Peak(5,:), 'xr')
xlim([the_xticks_ind(1) the_xticks_ind(end)]);
xticks(the_xticks_ind) %the_x
xticklabels(the_xticks) %x_tick
xtickangle(45)
legend('data','peaks ','lows')
hold off

%% IGNORE!!!
clear;clc;
%full =  xlsread('Calculations Apparel Industry.xlsx');
load Market_Cap.mat
%Data provided in quarters
%

%Nike = Company();
%Nike.Market_Cap = Nike_MC;
%Adidas = Company();


Nike_MC_peak = TTR_Calc(Nike.Market_Cap,2001, 0.25, 0.25);
Adidas_MC_peak = TTR_Calc(Adidas.Market_Cap,2001, 0.25, 0.25);

Nike_EBITDA_peak = TTR_Calc(Nike.EBITDA,2000, 1, 1);
Adidas_EBITDA_peak = TTR_Calc(Adidas.EBITDA,2000, 1, 1);
