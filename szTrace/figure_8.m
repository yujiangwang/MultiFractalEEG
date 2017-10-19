% Authors: Lucas Franca(1), Yujiang Wang(1,2,3)
%
% 1 Department of Clinical and Experimental Epilepsy, UCL Institute of 
% Neurology, University College London, London, United Kingdom
%
% 2 Interdisciplinary Computing and Complex BioSystems (ICOS) research 
% group, School of Computing Science, Newcastle University, Newcastle upon 
% Tyne, United Kingdom
%
% 3 Institute of Neuroscience, Newcastle University, Newcastle upon Tyne,
% United Kingdom
%
% email address: lucas.franca.14@ucl.ac.uk, Yujiang.Wang@newcastle.ac.uk
% Website: https://lucasfr.github.io/, http://xaphire.de/

%% NHNN1

clear
close all
addpath(genpath('../libs/'))

%% OPENING THE DATA

load('JR_12062011_1630_1730_ch1.mat');

%% SETTING PARAMETERS

segmentSize = 1024; qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0.9;
sampRate = 512; tWindow = segmentSize/sampRate; szStart = 894773/512; 
szStop = 907973/512;

% %% FILTERING COMPONENTS OF FREQUENCIES BELLOW 1 Hz TO REMOVE DC SHIFTS
% 
% [b,a] = butter(2, 0.5/(sampRate/2), 'high');
% data = filtfilt(b,a,double(data));

%% MULTIFRACTAL SPECTRA (NORMALISED FOR THE WHOLE SEGMENT)

[chj.deltaFR,chj.widthR] = ...
    chj_nr_meth_r(data,segmentSize,qi,qf,dq,Np,Ra,Io);

%% MULTIFRACTAL SPECTRA (NORMALISED PER EPOCH)

[chj.deltaF,chj.width] = ...
    chj_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io);


%% STANDARD DEVIATION AND MEAN

[~,~,dStat] = mstdvar(data,tWindow,sampRate);

%pBandMat = powerBands(data,sampRate,tWindow);
%% LINE LENGTH

ll = llength(data,sampRate,tWindow);


%% PLOTTING

figure
ttime = length(data)/sampRate/length(data):length(data)/sampRate/...
    length(data):length(data)/sampRate;
subplot(5,1,1)
plot(ttime,data,'Color',[0 90 50]./255)
hold on
plot([szStart szStart],[min(data) max(data)],'Color',[202 0 32]./255, ...
    'LineWidth',2)
plot([szStop szStop],[min(data) max(data)],'Color', [202 0 32]./255, ...
    'LineWidth',2)
hold off
xlim([2 3600])
ylim([min(data) max(data)])
xlabel('Time (s)')
ylabel('\muV')
title('EEG')
subplot(5,1,2)
plot(tWindow:tWindow:tWindow*length(chj.widthR(:,2)),chj.widthR(:,2),...
    'Color',[35 139 69]./255)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(chj.widthR(:,2),'movmedian',...
    50)),smoothdata(chj.widthR(:,2),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(chj.widthR(:,2)) max(chj.widthR(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[min(chj.widthR(:,2)) max(chj.widthR(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
hold off
xlim([2 3600])
ylim([0.2 0.8])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('Multifractal spectra width')
subplot(5,1,3)
plot(tWindow:tWindow:tWindow*length(chj.width(:,2)),chj.width(:,2),...
    'Color',[65 171 93]./255)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(chj.width(:,2),'movmedian',...
    50)),smoothdata(chj.width(:,2),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(chj.width(:,2)) 0.8],'Color',...
    [202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[min(chj.width(:,2)) 0.8],'Color',...
    [202 0 32]./255, 'LineWidth',2)
hold off
xlim([2 3600])
ylim([0.2 0.8])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('Multifractal spectra width (normalised)')
subplot(5,1,4)
plot(tWindow:tWindow:tWindow*length(dStat(:,2)),dStat(:,2),...
    'Color',[116 196 118]./255)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(dStat(:,2),'movmedian',50)),...
    smoothdata(dStat(:,2),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(dStat(:,2)) max(dStat(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[min(dStat(:,2)) max(dStat(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
hold off
xlim([2 3600])
ylim([min(dStat(:,2)) max(dStat(:,2))])
xlabel('Time (s)')
ylabel('\sigma')
title('St. Deviation')
subplot(5,1,5)
plot(tWindow:tWindow:tWindow*length(ll),ll, 'Color',[161 217 155]./255)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(ll,'movmedian',50)),...
    smoothdata(ll,'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(ll) max(ll)],'Color',[202 0 32]./255, ...
    'LineWidth',2)
plot([szStop szStop],[min(ll) max(ll)],'Color', [202 0 32]./255, ...
    'LineWidth',2)
hold off
xlim([2 3600])
ylim([min(ll) max(ll)])
xlabel('Time (s)')
ylabel('LL')
title('Line Length')


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% I001_P005_D01
% 
% clear
% 
% %% OPENING THE DATA
% 
% load('I001_P005_D01.mat');
% 
% %% SETTING PARAMETERS
% 
% qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0.9; id='I001_P005_D01'; seg = '1';
% chNum = 1; szPoint = 25220; szPointF = 25290.5; szStart = 451;
% sampRate = 5000; segmentSize = 1024; tWindow = segmentSize/sampRate;
% 
% szStop = szStart + szPointF - szPoint;
% 
% %% FILTERING COMPONENTS OF FREQUENCIES BELLOW 1 Hz TO REMOVE DC SHIFTS
% 
% [b,a] = butter(2, 1/(sampRate/2), 'high');
% data = filtfilt(b,a,values);
% 
% %% TRIMMING TIME SERIES
% 
% segmentSize = sampRate*tWindow;
% siz = floor(length(data)/segmentSize)*segmentSize;
% data = data(1:siz,1)';
% 
% %% MULTIFRACTAL SPECTRA (NORMALISED FOR THE WHOLE SEGMENT)
% 
% [chj.deltaFR,chj.widthR] = ...
%     chj_nr_meth_r(data,segmentSize,qi,qf,dq,Np,Ra,Io);
% 
% %% MULTIFRACTAL SPECTRA (NORMALISED PER EPOCH)
% 
% [chj.deltaF,chj.width] = ...
%     chj_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io);
% 
% 
% %% STANDARD DEVIATION AND MEAN
% 
% [~,~,dStat] = mstdvar(data,tWindow,sampRate);
% 
% %pBandMat = powerBands(data,sampRate,tWindow);
% %% LINE LENGTH
% 
% ll = llength(data,sampRate,tWindow);
% 
% 
% %% PLOTTING
% 
% figure
% ttime = length(data)/sampRate/length(data):length(data)/sampRate/...
%     length(data):length(data)/sampRate;
% subplot(5,1,1,'Color',[8 69 148]./255)
% plot(ttime,data)
% hold on
% plot([szStart szStart],[min(data) max(data)],'Color',[202 0 32]./255, ...
%     'LineWidth',2)
% plot([szStop szStop],[min(data) max(data)],'Color', [202 0 32]./255, ...
%     'LineWidth',2)
% hold off
% xlim([0 890])
% ylim([min(data) max(data)])
% xlabel('Time (s)')
% ylabel('\muV')
% title('EEG')
% subplot(5,1,2)
% plot(tWindow:tWindow:tWindow*length(chj.widthR(:,2)),chj.widthR(:,2),...
%     'Color',[33 113 181]./255)
% hold on
% plot(tWindow:tWindow:tWindow*length(smoothdata(chj.width(:,2),'movmedian',50)),...
%     smoothdata(chj.widthR(:,2),'movmedian',50),'Color',[0 0 0]./255,...
%     'LineWidth',2)
% plot([szStart szStart],[min(chj.widthR(:,2)) max(chj.widthR(:,2))],'Color',...
%     [202 0 32]./255, 'LineWidth',2)
% plot([szStop szStop],[min(chj.widthR(:,2)) max(chj.widthR(:,2))],'Color',...
%     [202 0 32]./255, 'LineWidth',2)
% hold off
% xlim([0 890])
% ylim([min(chj.widthR(:,2)) max(chj.widthR(:,2))])
% xlabel('Time (s)')
% ylabel('\Delta\alpha')
% title('Multifractal spectra width')
% subplot(5,1,3)
% plot(tWindow:tWindow:tWindow*length(chj.width(:,2)),chj.width(:,2),...
%     'Color',[66 146 198]./255)
% hold on
% plot(tWindow:tWindow:tWindow*length(smoothdata(chj.width(:,2),'movmedian',50)),...
%     smoothdata(chj.width(:,2),'movmedian',50),'Color',[0 0 0]./255,...
%     'LineWidth',2)
% plot([szStart szStart],[min(chj.width(:,2)) max(chj.width(:,2))],'Color',...
%     [202 0 32]./255, 'LineWidth',2)
% plot([szStop szStop],[min(chj.width(:,2)) max(chj.width(:,2))],'Color',...
%     [202 0 32]./255, 'LineWidth',2)
% hold off
% xlim([0 890])
% ylim([min(chj.width(:,2)) max(chj.width(:,2))])
% xlabel('Time (s)')
% ylabel('\Delta\alpha')
% title('Multifractal spectra width (normalised)')
% subplot(5,1,4)
% plot(tWindow:tWindow:tWindow*length(dStat(:,2)),dStat(:,2),...
%     'Color',[107 174 214]./255)
% hold on
% plot(tWindow:tWindow:tWindow*length(smoothdata(dStat(:,2),'movmedian',50)),...
%     smoothdata(dStat(:,2),'movmedian',50),'Color',[0 0 0]./255,...
%     'LineWidth',2)
% plot([szStart szStart],[min(dStat(:,2)) max(dStat(:,2))],'Color',...
%     [202 0 32]./255, 'LineWidth',2)
% plot([szStop szStop],[min(dStat(:,2)) max(dStat(:,2))],'Color',...
%     [202 0 32]./255, 'LineWidth',2)
% hold off
% xlim([0 890])
% ylim([min(dStat(:,2)) max(dStat(:,2))])
% xlabel('Time (s)')
% ylabel('\sigma')
% title('St. Deviation')
% subplot(5,1,5)
% plot(tWindow:tWindow:tWindow*length(ll),ll,'Color',[158 202 225]./255)
% hold on
% plot(tWindow:tWindow:tWindow*length(smoothdata(ll,'movmedian',50)),...
%     smoothdata(ll,'movmedian',50),'Color',[0 0 0]./255,...
%     'LineWidth',2)
% plot([szStart szStart],[min(ll) max(ll)],'Color',[202 0 32]./255, ...
%     'LineWidth',2)
% plot([szStop szStop],[min(ll) max(ll)],'Color', [202 0 32]./255, ...
%     'LineWidth',2)
% hold off
% xlim([0 890])
% ylim([min(ll) max(ll)])
% xlabel('Time (s)')
% ylabel('LL')
% title('Line Length')

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