
classdef Company
    properties (Access = public)
        Assets;
        Liabilities;
        Equity;
        Total_Debt;
        
        Market_Cap;
        Stock_as_Percent = [];
        Revenue;
        EBITDA;
        Income;
        
        Peaks_Rev = [];
        Peaks_EBITDA = [];
        Peaks_Income = [];
        
        Avg_TTR_Rev = [];
        Avg_TTR_EBITDA = [];
        Avg_TTR_Income = [];
        
        PtoT_Rev; %peak to trough
        PtoT_EBITDA;
        PtoT_Income;
        
        PtoT_Ratio_Rev;
        PtoT_Ratio_EBITDA;
        PtoT_Ratio_Income;
        
        Start_Year;
        
        filter;
        
        Data_for_Graph = [];
    end
    
    methods
        %constructor
        function obj = Company()
            obj.Assets = [];
            obj.Liabilities = [];
            obj.Equity = [];
            obj.Total_Debt = [];
            
            obj.Revenue = [];
            obj.EBITDA = [];
            obj.Income = [];
            
            obj.filter = 0;

            
        end
        
        function obj = CalcPeak(obj)
            obj.Peaks_Rev = TTR_Calc(obj.Revenue,1,1,obj.filter);
            obj.Peaks_EBITDA = TTR_Calc(obj.EBITDA,1,1,obj.filter);
            obj.Peaks_Income = TTR_Calc(obj.Income,1,1,obj.filter);
            
            obj.Avg_TTR_Rev = mean(obj.Peaks_Rev(3,:));
            obj.PtoT_Rev = mean(obj.Peaks_Rev(2,:)- obj.Peaks_Rev(5,:));
            obj.PtoT_Ratio_Rev = obj.Peaks_Rev(6,:);

            obj.Avg_TTR_EBITDA = mean(obj.Peaks_EBITDA(3,:));
            obj.PtoT_EBITDA = mean(obj.Peaks_EBITDA(2,:)- obj.Peaks_EBITDA(5,:));
            obj.PtoT_Ratio_EBITDA = obj.Peaks_EBITDA(6,:);
            
            obj.Avg_TTR_Income = mean(obj.Peaks_Income(3,:));
            obj.PtoT_Income = mean(obj.Peaks_Income(2,:)- obj.Peaks_Income(5,:));
            obj.PtoT_Ratio_Income = obj.Peaks_Income(6,:);
            
        end
        
        function [Peaks_Data, Plot_Data]= Peak_Selector(obj,i)
           if i == 1
               Peaks_Data = obj.Peaks_Rev;
               Plot_Data = obj.Revenue;
           elseif i == 2
               Peaks_Data = obj.Peaks_EBITDA;
               Plot_Data = obj.EBITDA;
           elseif i == 3
               Peaks_Data = obj.Peaks_Income;
               Plot_Data = obj.Income;
           else
               error('No such option!')
           end
        end
    end
    
end

        