% Authors: Lucas França(1), Yujiang Wang(1,2,3)

% 1 Department of Clinical and Experimental Epilepsy, UCL Institute of Neurology,
% University College London, London, United Kingdom

% 2 Interdisciplinary Computing and Complex BioSystems (ICOS) research group,
% School of Computing Science, Newcastle University, Newcastle upon Tyne,
% United Kingdom

% 3 Institute of Neuroscience, Newcastle University, Newcastle upon Tyne,
% United Kingdom

% email address: lucas.franca.14@ucl.ac.uk, Yujiang.Wang@newcastle.ac.uk
% Website: https://lucasfr.github.io/, http://xaphire.de/

function swSpotEval(szRaw,nullRaw,filename,wSizes,szNum,...
    sampRate,sampRates,qi,qf,dq,Io,Np,Ra)
% This function calculates for each input channel of each time series
% segment with a seizure the effect size of the MF measure interictally vs
% ictally. It saves the results in filename.

for z = 1:length(wSizes)


    for k = 1:length(szRaw) %loop through channels

        [b,a] = butter(2, 1/(sampRate/2), 'high');
        szRaw{k} = filtfilt(b,a,szRaw{k});
        nullRaw{k} = filtfilt(b,a,nullRaw{k});

        for i = 1:length(sampRates)

            %seizure segment
            values = downsample(szRaw{k},sampRate/sampRates(i));
            factor = wSizes(z)/(sampRate/(sampRate/sampRates(i)));

            siz = floor(length(values)/16384)*16384;
            data = values(1:siz,1)';

            [~,widthT] = ...
                chj_nr_meth(data,wSizes(z),qi,qf,dq,Np,Ra,Io);
            width{i,k,z} = widthT(:,2);

            szMean(i,k,z) = mean(width{i,k,z});

            %interictal segment
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
