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

function [classANOVA] = classDSamp(hypnogram,mfract,factor)

% THIS FUNCTION DOWNSAMPLES THE CONTINUOUS ANNOTATIONS TO A SAMPLING RATE
% COMPATIBLE TO THE MULTIFRACTAL METRICS.

classANOVA = zeros(length(mfract),1);
classANOVA(1) = hypnogram(1);

for i=2:length(mfract)

    classANOVA(i) = hypnogram(floor((i-1)*factor));

end

end
