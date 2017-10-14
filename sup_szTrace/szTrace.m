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

segmentSize = 2048; qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0;
sampRate = 512; tWindow = segmentSize/sampRate; szStart = 894773/512; 
szStop = 907973/512;

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
ttime = length(data)/sampRate/length(data):length(data)/sampRate/length(data):length(data)/sampRate;
subplot(4,1,1)
plot(ttime,data)
hold on
plot([szStart szStart],[min(data) max(data)],'Color',[202 0 32]./255, ...
    'LineWidth',2)
plot([szStop szStop],[min(data) max(data)],'Color', [202 0 32]./255, ...
    'LineWidth',2)
hold off
xlim([700 1800])
ylim([min(data) max(data)])
xlabel('Time (s)')
ylabel('\muV')
title('EEG - channel 1')
subplot(4,1,2)
plot(tWindow:tWindow:tWindow*length(chj.width(:,2)),chj.width(:,2))
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(chj.width(:,2),'movmedian',50)),...
    smoothdata(chj.width(:,2),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(chj.width(:,2)) max(chj.width(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[min(chj.width(:,2)) max(chj.width(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
hold off
xlim([700 1800])
ylim([min(chj.width(:,2)) max(chj.width(:,2))])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('Multifractal spectra width')
subplot(4,1,3)
plot(tWindow:tWindow:tWindow*length(dStat(:,2)),dStat(:,2))
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(dStat(:,2),'movmedian',50)),...
    smoothdata(dStat(:,2),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(dStat(:,2)) max(dStat(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[min(dStat(:,2)) max(dStat(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
hold off
xlim([700 1800])
ylim([min(dStat(:,2)) max(dStat(:,2))])
xlabel('Time (s)')
ylabel('\sigma')
title('St. Deviation')
subplot(4,1,4)
plot(tWindow:tWindow:tWindow*length(ll),ll)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(ll,'movmedian',50)),...
    smoothdata(ll,'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(ll) max(ll)],'Color',[202 0 32]./255, ...
    'LineWidth',2)
plot([szStop szStop],[min(ll) max(ll)],'Color', [202 0 32]./255, ...
    'LineWidth',2)
hold off
xlim([700 1800])
ylim([min(ll) max(ll)])
xlabel('Time (s)')
ylabel('LL')
title('Line Length')


% %% Yuj's hacking exploration
% dtime=2:2:2*length(chj.width(:,2));
% chts=chj.width(:,2);
% stdts=dStat(:,2);
% 
% tid=dtime<1800 & dtime>800;
% figure(1)
% scatter(chts(tid),stdts(tid));
% lsline
% figure(2)
% ndhist([chts(tid),stdts(tid)])
% 
% 
% [c,p]=corr(chts(tid),stdts(tid))