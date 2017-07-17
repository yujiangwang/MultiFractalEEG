function [W] = tweakedFBM(n,H,r0,rndSeed,factor)

rng(rndSeed)

r = nan(n+1,1); r(1) = r0;

for k = 1:n
    
    r(k+1) = 0.5*((k+1)^(2*H) - 2*k^(2*H) + (k-1)^(2*H));
    
end

r = [r; r(end-1:-1:2)]; % first rwo of circulant matrix
lambda = real(fft(r))/(2*n); % eigenvalues
W = fft(sqrt(lambda).*complex(factor*randn(2*n,1),factor*randn(2*n,1)));
W = n^(-H)*cumsum(real(W(1:n+1))); % rescale

end