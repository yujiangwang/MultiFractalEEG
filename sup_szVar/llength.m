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

function [ll] = llength(signal,sampRate,tWindow)

segmentSize = sampRate*tWindow;
siz = floor(length(signal)/segmentSize)*segmentSize;
signal = signal(1,1:siz);
signal = reshape(signal,tWindow*sampRate,[]);
ll = zeros(length(signal),1);

for i=1:size(signal,2)

   sig = signal(:,i);
   summation = 0;

   for k=2:length(sig)
          summation = summation + abs(sig(k-1) - sig(k));
   end

   ll(i,1) = summation;

end

end
