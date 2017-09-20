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

%% OPENING THE DATA

load('JR_12062011_1630_1730_ch1.mat');

%% SETTING PARAMETERS

tWindow = 2; segmentSize = 1024; qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0;
sampRate = 512;

%% MULTIFRACTAL SPECTRA (NORMALISED PER EPOCH)

[chj.width,chj.deltaF] = ...
    chj_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io);


%% STANDARD DEVIATION AND MEAN

[~,~,dStat] = mstdvar(data,tWindow,sampRate);

%pBandMat = powerBands(data,sampRate,tWindow);
%% LINE LENGTH

ll = llength(data,sampRate,tWindow);


%% PLOTTING

figure
subplot(4,1,1)
plot(3600/length(data):3600/length(data):length(data)/512,data)
xlim([3600/length(data) 3600])
ylim([-500 500])
xlabel('Time (s)')
ylabel('\muV')
title('EEG - channel 1')
subplot(4,1,2)
plot(2:2:2*length(chj.width(:,2)),chj.width(:,2))
hold on
plot(2:2:2*length(smoothdata(chj.width(:,2),'movmedian',50)),...
    smoothdata(chj.width(:,2),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
hold off
xlim([2 3600])
ylim([0.5 1.5])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('Multifractal spectra width')
subplot(4,1,3)
plot(2:2:2*length(dStat(:,2)),dStat(:,2))
hold on
plot(2:2:2*length(smoothdata(dStat(:,2),'movmedian',50)),...
    smoothdata(dStat(:,2),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
hold off
xlim([2 3600])
xlabel('Time (s)')
ylabel('\sigma')
title('St. Deviation')
subplot(4,1,4)
plot(2:2:2*length(ll),ll)
hold on
plot(2:2:2*length(smoothdata(ll,'movmedian',50)),...
    smoothdata(ll,'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
hold off
xlim([2 3600])
xlabel('Time (s)')
ylabel('LL')
title('Line Length')