%% Revenue and Income
clear;clc;
[full_Inc, full_Inc_text, ~] = xlsread('Revenues by Quarters.xlsx', 'Last 20 years'); %import Income Statement info
[full_BS, full_BS_text, ~] = xlsread('Revenues by Quarters.xlsx', 'Balance Sheet Data');  %Import Balance Sheet info

% 46:end for March 2012+. 
%full_Inc = full_Inc(:, 1:45) 
%full_Inc_text = full_Inc_text(:, 1:45) 
%full_BS = full_BS(:, 1:44) 
%full_BS_text = full_BS_text(:, 1:44) 

x_ticks = full_Inc_text(2,2:end-1);

proportion_label = length(x_ticks)/10;
count =1;
for i = 1:proportion_label:length(x_ticks)
    the_xticks_ind(count) = floor(i);
    temp = splitlines(x_ticks(floor(i)));
    the_xticks(count) = temp(end);
    
    count = count + 1;
end


if floor(proportion_label) ~= proportion_label
    the_xticks_ind(count) = length(x_ticks);
    temp = splitlines(x_ticks(the_xticks_ind(count)));
    the_xticks(count)= temp(end);
end
clear count temp;

for i = 1:11 %9 companies
    Company_Obj(i) = Company();
    Company_Obj(i).Revenue = full_Inc(i,:);
    Company_Obj(i).EBITDA = full_Inc(13+i,:);
    Company_Obj(i).Income = full_Inc(26+i,:);

    Company_Obj(i).Assets = full_BS(i,:);
    Company_Obj(i).Liabilities = full_BS(13+i,:);
    Company_Obj(i).Equity(i,:) = full_BS(26+i,:);
    Company_Obj(i).Total_Debt = full_BS(39+i,:);
    
    Company_Obj(i) = Company_Obj(i).CalcPeak();
end

Company_Names = {'Adidas','VF Corp','NIKE','Gildan','PUMA','Burberry','Hanesbrands','Under Armour','Moncler','Benchmark Average','Benchmark Median'};
Mode_Names = {'Revenue','EBITDA', 'Income'};

mode = 2;
for i = 1:11
    [Peaks_Data, Plot_Data] = Company_Obj(i).Peak_Selector(mode);
    the_title = sprintf('%s - %s',string(Company_Names(i)), string(Mode_Names(mode)));

fprintf('%s: #REVENUE - Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',string(Company_Names(i)), Company_Obj(i).Avg_TTR_Rev, Company_Obj(i).PtoT_Rev);
fprintf('%s: #EBITDA - Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',string(Company_Names(i)), Company_Obj(i).Avg_TTR_EBITDA, Company_Obj(i).PtoT_EBITDA);
fprintf('%s: #INCOME - Avg TTR: %3.2f. Avg Peak-to-Trough Magnitude: %3.2f \n',string(Company_Names(i)), Company_Obj(i).Avg_TTR_Income, Company_Obj(i).PtoT_Income);

data_matrix(i,:) = [Company_Obj(i).Avg_TTR_Rev, Company_Obj(i).PtoT_Rev, mean(Company_Obj(i).PtoT_Ratio_Rev) max(Company_Obj(i).PtoT_Ratio_Rev)];
data_matrix2(i,:) = [Company_Obj(i).Avg_TTR_EBITDA, Company_Obj(i).PtoT_EBITDA, mean(Company_Obj(i).PtoT_Ratio_EBITDA) max(Company_Obj(i).PtoT_Ratio_EBITDA)];
data_matrix3(i,:) = [Company_Obj(i).Avg_TTR_Income, Company_Obj(i).PtoT_Income, mean(Company_Obj(i).PtoT_Ratio_Income) max(Company_Obj(i).PtoT_Ratio_Income)];

figure(i)
hold on
legend on
grid on
plot(Plot_Data)
title(the_title)
scatter(Peaks_Data(1,:), Peaks_Data(2,:), '*g')
scatter(Peaks_Data(4,:), Peaks_Data(5,:), 'xr')
xlim([the_xticks_ind(1) the_xticks_ind(end)]);
xticks(the_xticks_ind); %the_x
xticklabels(the_xticks); %x_tick
xtickangle(45);
legend('data','peaks ','lows')
hold off

picname = sprintf('%s.png',the_title);
%saveas(gcf, picname); %comment out when unneeded
end
data_matrix_full = [data_matrix;data_matrix2;data_matrix3];
writematrix(data_matrix_full,'Test.csv')
%close all
