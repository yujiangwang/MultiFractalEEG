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

function [pBandMat] = powerBands(series,sampRate,segmentSize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FILTERS LOT

% %% 0.5-4
%
% [b,a] = butter(2, 4/(sampRate/2), 'low');
% delta = filtfilt(b,a,series);
% [b,a] = butter(2, 0.5/(sampRate/2), 'high');
% delta = filtfilt(b,a,delta);


%% 4-8

[b,a] = butter(2, 8/(sampRate/2), 'low');
theta = filtfilt(b,a,series);
[b,a] = butter(2, 4/(sampRate/2), 'high');
theta = filtfilt(b,a,theta);

%% 8-15

[b,a] = butter(2, 15/(sampRate/2), 'low');
alpha = filtfilt(b,a,series);
[b,a] = butter(2, 8/(sampRate/2), 'high');
alpha = filtfilt(b,a,alpha);

%% 15-30

[b,a] = butter(2, 30/(sampRate/2), 'low');
beta = filtfilt(b,a,series);
[b,a] = butter(2, 15/(sampRate/2), 'high');
beta = filtfilt(b,a,beta);

%% 30-60

[b,a] = butter(2, 60/(sampRate/2), 'low');
gamma = filtfilt(b,a,series);
[b,a] = butter(2, 30/(sampRate/2), 'high');
gamma = filtfilt(b,a,gamma);

%% 60-120

[b,a] = butter(2, 120/(sampRate/2), 'low');
hGamma = filtfilt(b,a,series);
[b,a] = butter(2, 60/(sampRate/2), 'high');
hGamma = filtfilt(b,a,hGamma);

% %% 120-250
% [b,a] = butter(2, 250/(sampRate/2), 'low');
% ripple = filtfilt(b,a,series);
% [b,a] = butter(2, 120/(sampRate/2), 'high');
% ripple = filtfilt(b,a,ripple);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RESHAPE PROC.

delta = reshape(delta,segmentSize,[]);
theta = reshape(theta,segmentSize,[]);
alpha = reshape(alpha,segmentSize,[]);
beta = reshape(beta,segmentSize,[]);
gamma = reshape(gamma,segmentSize,[]);
hGamma = reshape(hGamma,segmentSize,[]);
% ripple = reshape(ripple,segmentSize,[]);
% fRipple = reshape(fRipple,segmentSize,[]);
raw = reshape(series,segmentSize,[]);

%% POWER OPS.

deltaP = zeros(length(delta(1,:)),1);
thetaP = zeros(length(theta(1,:)),1);
alphaP = zeros(length(alpha(1,:)),1);
betaP = zeros(length(beta(1,:)),1);
gammaP = zeros(length(gamma(1,:)),1);
hGammaP = zeros(length(hGamma(1,:)),1);
% rippleP = zeros(length(ripple(1,:)),1);
% fRippleP = zeros(length(fRipple(1,:)),1);
rawP = zeros(length(raw(1,:)),1);

for i=1:length(delta(1,:))

    deltaP(i,1) = sumsqr(delta(:,i));
    thetaP(i,1) = sumsqr(theta(:,i));
    alphaP(i,1) = sumsqr(alpha(:,i));
    betaP(i,1) = sumsqr(beta(:,i));
    gammaP(i,1) = sumsqr(gamma(:,i));
    hGammaP(i,1) = sumsqr(hGamma(:,i));
%     rippleP(i,1) = sumsqr(ripple(:,i));
%     fRippleP(i,1) = sumsqr(fRipple(:,i));
    rawP(i,1) = sumsqr(raw(:,i));

end

% RELATIVE POWER

deltaPR = deltaP./rawP;
thetaPR = thetaP./rawP;
alphaPR = alphaP./rawP;
betaPR = betaP./rawP;
gammaPR = gammaP./rawP;
hGammaPR = hGammaP./rawP;
% ripplePR = rippleP./rawP;
% fRipplePR = fRippleP./rawP;

pBandMat = horzcat(deltaPR,thetaPR,alphaPR,betaPR,gammaPR,hGammaPR);

end
