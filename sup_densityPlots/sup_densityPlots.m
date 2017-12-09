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

clear
close all
addpath(genpath('../libs/'))
addpath(genpath('../data/'))

%% OPENING THE DATA

load('JR_12062011_1630_1730_ch1.mat');

%% SETTING PARAMETERS

tWindow = 2; segmentSize = 1024; qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0;
sampRate = 512;

%% MULTIFRACTAL SPECTRA (NORMALISED PER EPOCH)

[chj.deltaF,chj.width] = ...
    chj_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io);

%% MULTIFRACTAL SPECTRA (NORMALISED ON THE WHOLE DATA SERIES)
%note that Chhabra Jensen only accepts positive values as input time
%series, hence the sigmoid transform is neccessary in any case

x = (data - mean(data))/std(data);
sigma = 1./(1 + exp(-x));

[chjAll.width,chjAll.deltaF] = ...
    chj_nr_meth_n(sigma,segmentSize,qi,qf,dq,Np,Ra,Io);

%% STANDARD DEVIATION AND MEN

[~,~,dStat] = mstdvar(data,tWindow,sampRate);

% values = hist3([data1(:) data2(:)],[51 51]);
figure
[values, centers] = hist3([chj.width(:,2) dStat(:,2)],[70 70]);
imagesc(centers{:},values.')
colorbar
axis xy
xlabel('\Delta\alpha*')
ylabel('St. Dev.')
set(gca,'FontSize',18,'FontName','Times')

figure
[values, centers] = hist3([chjAll.width(:,2) dStat(:,2)],[70 70]);
imagesc(centers{:},values.')
colorbar
axis xy
xlabel('\Delta\alpha')
ylabel('St. Dev.')
set(gca,'FontSize',18,'FontName','Times')