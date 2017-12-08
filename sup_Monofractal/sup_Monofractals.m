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


%% External function such as dfa() and Higuchi_FD() were not checked in detail
clear
close all
clc
addpath(genpath('../libs/'))
addpath(genpath('../data/'))

%% LOADING EEG DATA

load('JR_12062011_1630_1730_ch1.mat')

%% PARAMETERS

segmentSize = 1024; szStart = 894773/512; szStop = 907973/512; sampRate = 512; 
tWindow = segmentSize/sampRate;

%% DFA AND DESCRIPTIVE STATISTICS

tic
[dfaFD] = dfa_nr_meth(data,segmentSize,8,2); % 2 - dyadic scale
toc
tic
[dfaFDn] = dfa_nr_meth_n(data,segmentSize,8,2);
toc
tic
[mVal,stdVal,~] = mstdvar(data,2,512);
toc


%% HIGUCHI METHOD
tic
[HigFD] = higuchi_nr_meth(data,segmentSize,4);
toc
[HigFDn] = higuchi_nr_meth_n(data,segmentSize,4);

%% SAVING OUTPUTS

save('monofractal.mat','dfaFD','dfaFDn','mVal','stdVal','HigFD','HigFDn')


%% PLOTTING THE FIGURE

figure;

subplot(6,1,1)
plot((1:length(data))/512,data,'Color',[33 102 172]./255)
hold on
plot([szStart szStart],[min(data) max(data)],'Color',[202 0 32]./255, ...
    'LineWidth',2)
plot([szStop szStop],[min(data) max(data)],'Color', [202 0 32]./255, ...
    'LineWidth',2)
hold off
xlim([1 length(data)]/512)
ylim([min(data) max(data)])
xlabel('Time (s)')
ylabel('\muV')
title('EEG')

subplot(6,1,2)
plot(2*(1:length(stdVal)),stdVal,'Color',[67 147 195]./255)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(stdVal,'movmedian',50)),...
    smoothdata(stdVal,'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(stdVal) max(stdVal)],'Color',[202 0 32]./255, ...
    'LineWidth',2)
plot([szStop szStop],[min(stdVal) max(stdVal)],'Color', [202 0 32]./255, ...
    'LineWidth',2)
hold off
xlim([1 length(data)]/512)
ylim([min(stdVal) max(stdVal)])
xlabel('Time (s)')
ylabel('\sigma')
title('St. Deviation')

subplot(6,1,3)
plot(2*(1:length(HigFDn)),HigFDn,'Color',[223 194 125]./255)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(HigFDn,'movmedian',50)),...
    smoothdata(HigFDn,'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(HigFDn) max(HigFDn)],'Color',[202 0 32]./255, ...
    'LineWidth',2)
plot([szStop szStop],[min(HigFDn) max(HigFDn)],'Color', [202 0 32]./255, ...
    'LineWidth',2)
hold off
xlim([1 length(data)]/512)
ylim([min(HigFDn) max(HigFDn)])
xlabel('Time (s)')
ylabel('HigFD')
title('Higuchi fractal dimension')

subplot(6,1,4)
plot(2*(1:length(HigFD)),HigFD,'Color',[191 129 45]./255)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(HigFD,'movmedian',50)),...
    smoothdata(HigFD,'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(HigFD) max(HigFD)],'Color',[202 0 32]./255, ...
    'LineWidth',2)
plot([szStop szStop],[min(HigFD) max(HigFD)],'Color', [202 0 32]./255, ...
    'LineWidth',2)
hold off
xlim([1 length(data)]/512)
ylim([min(HigFD) max(HigFD)])
xlabel('Time (s)')
ylabel('HigFD*')
title('Higuchi fractal dimension (normalised)')

subplot(6,1,5)
plot(2*(1:length(dfaFDn)),dfaFDn,'Color',[128 205 193]./255)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(dfaFDn,'movmedian',50)),...
    smoothdata(dfaFDn,'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(dfaFDn) max(dfaFDn)],'Color',[202 0 32]./255, ...
    'LineWidth',2)
plot([szStop szStop],[min(dfaFDn) max(dfaFDn)],'Color', [202 0 32]./255, ...
    'LineWidth',2)
hold off
xlim([1 length(data)]/512)
ylim([min(dfaFDn) max(dfaFDn)])
xlabel('Time (s)')
ylabel('H')
title('Detrended fluctuation analysis')

subplot(6,1,6)
plot(2*(1:length(dfaFD)),dfaFD,'Color',[53 151 143]./255)
hold on
plot(tWindow:tWindow:tWindow*length(smoothdata(dfaFD,'movmedian',50)),...
    smoothdata(dfaFD,'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
plot([szStart szStart],[min(dfaFD) max(dfaFD)],'Color',[202 0 32]./255, ...
    'LineWidth',2)
plot([szStop szStop],[min(dfaFD) max(dfaFD)],'Color', [202 0 32]./255, ...
    'LineWidth',2)
hold off
xlim([1 length(data)]/512)
ylim([min(dfaFD) max(dfaFD)])
xlabel('Time (s)')
ylabel('H*')
title('Detrended fluctuation analysis (normalised)')