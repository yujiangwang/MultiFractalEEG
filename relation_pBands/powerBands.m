function [pBandMat] = powerBands(series,sampRate,segmentSize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FILTERS LOT

%% 0.5-4

[b,a] = butter(2, 4/(sampRate/2), 'low');
delta = filtfilt(b,a,series);
[b,a] = butter(2, 0.5/(sampRate/2), 'high');
delta = filtfilt(b,a,delta);


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

%% 120-250
[b,a] = butter(2, 250/(sampRate/2), 'low');
ripple = filtfilt(b,a,series);
[b,a] = butter(2, 120/(sampRate/2), 'high');
ripple = filtfilt(b,a,ripple);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RESHAPE PROC.

delta = reshape(delta,segmentSize,[]);
theta = reshape(theta,segmentSize,[]);
alpha = reshape(alpha,segmentSize,[]);
beta = reshape(beta,segmentSize,[]);
gamma = reshape(gamma,segmentSize,[]);
hGamma = reshape(hGamma,segmentSize,[]);
ripple = reshape(ripple,segmentSize,[]);
raw = reshape(series,segmentSize,[]);

%% POWER OPS.

deltaP = zeros(length(delta(1,:)),1);
thetaP = zeros(length(theta(1,:)),1);
alphaP = zeros(length(alpha(1,:)),1);
betaP = zeros(length(beta(1,:)),1);
gammaP = zeros(length(gamma(1,:)),1);
hGammaP = zeros(length(hGamma(1,:)),1);
rippleP = zeros(length(ripple(1,:)),1);
rawP = zeros(length(raw(1,:)),1);

for i=1:length(delta(1,:))
    
    deltaP(i,1) = sumsqr(delta(:,i));
    thetaP(i,1) = sumsqr(theta(:,i));
    alphaP(i,1) = sumsqr(alpha(:,i));
    betaP(i,1) = sumsqr(beta(:,i));
    gammaP(i,1) = sumsqr(gamma(:,i));
    hGammaP(i,1) = sumsqr(hGamma(:,i));
    rippleP(i,1) = sumsqr(ripple(:,i));
    rawP(i,1) = sumsqr(raw(:,i));
    
end

% RELATIVE POWER

deltaPR = deltaP./rawP;
thetaPR = thetaP./rawP;
alphaPR = alphaP./rawP;
betaPR = betaP./rawP;
gammaPR = gammaP./rawP;
hGammaPR = hGammaP./rawP;
ripplePR = rippleP./rawP;

pBandMat = horzcat(deltaPR,thetaPR,alphaPR,betaPR,gammaPR,hGammaPR,ripplePR);

end