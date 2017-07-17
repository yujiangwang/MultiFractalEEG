function swSpotEval(szRaw,nullRaw,filename,wSizes,szNum,...
    sampRate,sampRates,qi,qf,dq,Io,Np,Ra)

for z = 1:length(wSizes)
    

    for k = 1:length(szRaw)
        
        [b,a] = butter(2, 1/(sampRate/2), 'high');
        szRaw{k} = filtfilt(b,a,szRaw{k});
        nullRaw{k} = filtfilt(b,a,nullRaw{k});
        
        for i = 1:length(sampRates)
            
            values = downsample(szRaw{k},sampRate/sampRates(i));
            factor = wSizes(z)/(sampRate/(sampRate/sampRates(i)));
            
            siz = floor(length(values)/16384)*16384;
            data = values(1:siz,1)';
            
            [~,widthT] = ...
                chj_nr_meth(data,wSizes(z),qi,qf,dq,Np,Ra,Io);
            width{i,k,z} = widthT(:,2);
            
            szMean(i,k,z) = mean(width{i,k,z});
            
            
            values = downsample(nullRaw{k},sampRate/sampRates(i));
            factor = wSizes(z)/(sampRate/(sampRate/sampRates(i)));
            
            siz = floor(length(values)/16384)*16384;
            data = values(1:siz,1)';
            
            [~,widthT] = ...
                chj_nr_meth(data,wSizes(z),qi,qf,dq,Np,Ra,Io);
            width{i,k,z} = widthT(:,2);
            
            interMean(i,k,z) = mean(width{i,k,z});
            interStd(i,k,z) = std(width{i,k,z});
            
            effSize(i,k,z) = ...
                (szMean(i,k,z) - interMean(i,k,z))/interStd(i,k,z);
            
        end
        
    end
    
end

save(filename,'effSize','szNum','wSizes','sampRates');

end
