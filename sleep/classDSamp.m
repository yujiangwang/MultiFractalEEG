function [classANOVA] = classDSamp(hypnogram,mfract,factor)

% THIS FUNCTION DOWNSAMPLES THE CONTINUOUS ANNOTATIONS TO A SAMPLING RATE
% COMPATIBLE TO THE MULTIFRACTAL METRICS.

classANOVA = zeros(length(mfract),1);
classANOVA(1) = hypnogram(1);

for i=2:length(mfract)
    
    classANOVA(i) = hypnogram(floor((i-1)*factor));
    
end

end