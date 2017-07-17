function [E] = szEntropy(series,sampRate,tWindow)

signal = reshape(series,tWindow*sampRate,[]);
E = zeros(length(signal),1);

for i=1:length(signal)
    
    sig = signal(:,i);
    E(i,1) = wentropy(sig,'shannon');
    
end

end