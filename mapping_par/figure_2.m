% checked by YW on 22nd July
% note the plotting is done separately by the R script.

clear
close all

%% LOADING DATA

load('JR_12062011_1630_1730_ch1.mat')

rng('default');
rng(666);%because Lucas loves the devil??? ;)
rand = randn(1,length(data));

rng('default');
rng(666);%more like the devil is in the details...
ix = randperm(length(data));
surrEEG(1,:) = data(ix);


%% DEFINING PARAMETERS OF ANALYSIS
v = 0.1:0.1:2;
segmentSize = 1024; qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0;
widthSign = zeros(length(data)/segmentSize,length(v));
widthRand = zeros(length(rand)/segmentSize,length(v));
widthSurr = zeros(length(surrEEG)/segmentSize,length(v));

% SIGNAL

parfor j = 1:length(v)

    x = (data - mean(data))/std(data);
    sigma = 1./(1 + exp(-v(j)*x));
    
    [~,width] = ...
    chj_nr_meth_n(sigma,segmentSize,qi,qf,dq,Np,Ra,Io);
    widthSign(:,j) = width(:,2);
    
end

% RANDOM

parfor j = 1:length(v)

    x = (rand - mean(rand))/std(rand);
    sigma = 1./(1 + exp(-v(j)*x));
    
    [~,width] = ...
    chj_nr_meth_n(sigma,segmentSize,qi,qf,dq,Np,Ra,Io);
    widthRand(:,j) = width(:,2);
    
end


% SURROGATE


parfor j = 1:length(v)

    x = (surrEEG - mean(surrEEG))/std(surrEEG);
    sigma = 1./(1 + exp(-v(j)*x));
    
    [~,width] = ...
    chj_nr_meth_n(sigma,segmentSize,qi,qf,dq,Np,Ra,Io);
    widthSurr(:,j) = width(:,2);
    
end


%% QUANTILES ESTIMATION

quantMatSign = zeros(length(0.1:0.1:2),4);
quantMatSurr = zeros(length(0.1:0.1:2),4);
quantMatRand = zeros(length(0.1:0.1:2),4);

quantMatSign(:,1) = 0.1:0.1:2;
quantMatSurr(:,1) = 0.1:0.1:2;
quantMatRand(:,1) = 0.1:0.1:2;

for i = 1:20
    
    quantMatSign(i,2) = quantile(widthSign(:,i),0.1);
    quantMatSign(i,3) = quantile(widthSign(:,i),0.5);
    quantMatSign(i,4) = quantile(widthSign(:,i),0.9);
    
    quantMatSurr(i,2) = quantile(widthSurr(:,i),0.1);
    quantMatSurr(i,3) = quantile(widthSurr(:,i),0.5);
    quantMatSurr(i,4) = quantile(widthSurr(:,i),0.9);
    
    quantMatRand(i,2) = quantile(widthRand(:,i),0.1);
    quantMatRand(i,3) = quantile(widthRand(:,i),0.5);
    quantMatRand(i,4) = quantile(widthRand(:,i),0.9);
    
end

quantMat = horzcat(quantMatSign,quantMatRand(:,2:4),quantMatSurr(:,2:4));

save('quantiles.mat','quantMat')
