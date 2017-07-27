function [sigma] = sigmoidTrans(raw,v)

x = (raw - mean(raw))/std(raw);
sigma = 1./(1 + exp(-v*x));

end