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

load('I001_P005_D01.mat');
data = values;

%% SETTING PARAMETERS

qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0.9; id='I001_P005_D01'; seg = '1';
chNum = 1; szPoint = 25220; szPointF = 25290.5; szStart = 451;
sampRate = 5000; segmentSize = 2048; tWindow = segmentSize/sampRate;

szStop = szStart + szPointF - szPoint;

%% MULTIFRACTAL SPECTRA (NORMALISED PER EPOCH)

segmentSize = sampRate*tWindow;
siz = floor(length(data)/segmentSize)*segmentSize;
data = data(1:siz,1);

[chj.width,chj.deltaF] = ...
    chj_nr_meth(data',segmentSize,qi,qf,dq,Np,Ra,Io);


%% STANDARD DEVIATION AND MEAN

[~,~,dStat] = mstdvar(data',tWindow,sampRate);

%pBandMat = powerBands(data,sampRate,tWindow);
%% LINE LENGTH

ll = llength(data',sampRate,tWindow);


%% PLOTTING

figure
ttime = 899.8912/length(data):899.8912/length(data):length(data)/5000;
subplot(4,1,1)
plot(ttime,data)
xlim([899.8912/length(data) 899.8912])
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
hold off
xlim([899.8912/length(data) 899.8912])
%ylim([0.5 1.5])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('Multifractal spectra width')
subplot(4,1,3)
plot(tWindow:tWindow:tWindow*length(dStat(:,2)),dStat(:,2))
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(dStat(:,2),'movmedian',50)),...
    smoothdata(dStat(:,2),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
hold off
xlim([899.8912/length(data) 899.8912])
xlabel('Time (s)')
ylabel('\sigma')
title('St. Deviation')
subplot(4,1,4)
plot(tWindow:tWindow:tWindow*length(ll),ll)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(ll,'movmedian',50)),...
    smoothdata(ll,'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
hold off
xlim([899.8912/length(data) 899.8912])
xlabel('Time (s)')
ylabel('LL')
title('Line Length')


%% Yuj's hacking exploration
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