% LICENSE
% 
% This software is licensed under an MIT License.
% 
% Copyright (c) 2018 Lucas G S França, Yujiang Wang.
% 
% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this software and associated documentation files (the "Software"), 
% to deal in the Software without restriction, including without limitation 
% the rights to use, copy, modify, merge, publish, distribute, sublicense, 
% and/or sell copies of the Software, and to permit persons to whom the 
% Software is furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included 
% in all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS 
% OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
% DEALINGS IN THE SOFTWARE.
% 
% Authors: Lucas França(1), Yujiang Wang(1,2,3)
% 
% 1 Department of Clinical and Experimental Epilepsy, UCL Institute of Neurology,
% University College London, London, United Kingdom
% 
% 2 Interdisciplinary Computing and Complex BioSystems (ICOS) research group,
% School of Computing Science, Newcastle University, Newcastle upon Tyne,
% United Kingdom
% 
% 3 Institute of Neuroscience, Newcastle University, Newcastle upon Tyne,
% United Kingdom
% 
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
