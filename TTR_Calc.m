%outputs a matrix of the following format[timestamp_peak; peak value; TTR_Count;timestamp_trough, trough value]

function [peak] = TTR_Calc(TheData, start_date, interval_length, filter_size)
k = interval_length;
count = 1;
TTR_Count = 0;
peak(1,count) = start_date;
peak(2,count) = TheData(1); %peak
peak(3,count) = TTR_Count;
peak(4,count) = start_date; %trough
peak(5,count) = TheData(1);
peak(6,count) = 0; %P-T-Ratio
rising(1) = 1; 
rising(2) = NaN;

for i = 2:length(TheData)
    %count days without data for TTR if previously in recovery
    if isnan(TheData(i))
        TTR_Count = TTR_Count + k;
        continue
    end
    
    if TheData(i) >= peak(2,count) || isnan(peak(2,count))
        rising(2) = 1;
    else 
        rising(2) = 0;
        TTR_Count = TTR_Count + 1;
    end
    
    if rising(1) ~= rising(2) %change in situation
        rising(1) = rising(2);
        if rising(2) == 1 %if we're on the rise, then update last peak's TTR.
            peak(3,count) = TTR_Count;
            %experimental
            if TTR_Count > filter_size       
                count = count + 1;
            else
                count = count;
            end
            %count = count + 1;
            TTR_Count = 0;
            peak(1,count) = start_date + k*(i-1);
            peak(2,count) = TheData(i);
            peak(3,count) = TTR_Count;
            peak(4,count) = TheData(i);
        else %We just started falling. Set new peak.
            peak(3,count) = TTR_Count;
            peak(4,count) = start_date + k*(i-1);
            peak(5,count) = TheData(i);
        end
    else
        if rising(2) == 0 %if we're just falling, count. 
            peak(3,count) = TTR_Count;
            
            if TheData(i) < peak(5,count) %update lowest point
                peak(4,count) = start_date + k*(i-1);
                peak(5,count) = TheData(i);
                %peak(6,count) = (peak(2,count) - peak(5,count))/(0.5*(peak(5,count)+peak(2,count)));
                peak(6,count) = (peak(2,count) - peak(5,count))/(peak(2,count)); % percent drop

            end
        else
            peak(1,count) = start_date + k*(i-1);
            peak(2,count) = TheData(i);
            %don't change TTR_Count
            TTR_Count = 0 ;
        end
        
    end 
end
