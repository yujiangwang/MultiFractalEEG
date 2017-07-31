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
