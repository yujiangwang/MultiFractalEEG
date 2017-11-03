% Authors: Lucas Franca(1), Yujiang Wang(1,2,3)

% 1 Department of Clinical and Experimental Epilepsy, UCL Institute of Neurology,
% University College London, London, United Kingdom

% 2 Interdisciplinary Computing and Complex BioSystems (ICOS) research group,
% School of Computing Science, Newcastle University, Newcastle upon Tyne,
% United Kingdom

% 3 Institute of Neuroscience, Newcastle University, Newcastle upon Tyne,
% United Kingdom

% email address: lucas.franca.14@ucl.ac.uk, Yujiang.Wang@newcastle.ac.uk
% Website: https://lucasfr.github.io/, http://xaphire.de/

function [W] = tweakedFBM(n,H,r0,rndSeed,factor)

%% DEFINING THE SEED FOR RANDOM NUMBER GENERATOR

rng(rndSeed)

%% CREATING VECTOR AND INITIAL VALUE

r = nan(n+1,1); r(1) = r0;

%% BUILDING THE FIRST ROW OF THE (n+1)x(n+1) TOEPLITZ MATRIX (OMEGA)

for k = 1:n

    r(k+1) = 0.5*((k+1)^(2*H) - 2*k^(2*H) + (k-1)^(2*H));

end

%% BUILDING THE FIRST ROW OF THE 2nx2n CIRCULANT MATRIX (SIGMA)

r = [r; r(end-1:-1:2)]; % first rwo of circulant matrix

%% EIGENVALUES MATRIX (LAMBDA)

lambda = real(fft(r))/(2*n);
% eigenvalues - taking real part to remove the negligible complex part

%% GENERATING THE NOISE COMPONENT

W = fft(sqrt(lambda).*factor.*complex(randn(2*n,1),randn(2*n,1)));
% multiply by some complex random numbers, where factor is the modulation

%% CUMULATIVE SUM AND FINAL fBm PROFILE

W = n^(-H)*cumsum(real(W(1:n+1))); % rescale

end
