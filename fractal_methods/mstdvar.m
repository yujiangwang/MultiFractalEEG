function [mVal,stdVal,dStat] = mstdvar(signal,tWindow,sampRate)

segmentSize = sampRate*tWindow;
siz = floor(length(signal)/segmentSize)*segmentSize;
signal = signal(1,1:siz);
signal = reshape(signal,tWindow*sampRate,[]);

for j = 1:size(signal,2)
    
    mVal(j) = nanmean(signal(:,j));
    stdVal(j) = nanstd(signal(:,j));
    
end

dStat = horzcat(mVal',stdVal');

end