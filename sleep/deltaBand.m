function [deltaPR] = deltaBand(series,sampRate,wSize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FILTERS LOT

%% 0.5-4

[b,a] = butter(4, 4/(sampRate/2), 'low');
delta = filter(b,a,series);
[b,a] = butter(4, 0.5/(sampRate/2), 'high');
delta = filter(b,a,delta);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RESHAPE PROC.

delta = reshape(delta,wSize,[]);
raw = reshape(series,wSize,[]);
%% POWER OPS.

deltaP = zeros(length(delta),1);
rawP = zeros(length(raw),1);

for i=1:length(delta)
    
    deltaP(i,1) = sumsqr(delta(:,i));
    rawP(i,1) = sumsqr(raw(:,i));
    
end

% RELATIVE POWER

deltaPR = deltaP./rawP;

end