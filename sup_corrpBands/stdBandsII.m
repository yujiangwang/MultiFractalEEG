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


clear
%close all
addpath(genpath('../libs/'))
addpath(genpath('../data/'))

%% OPENING THE DATA

load('I001_P005_D01.mat');

%% SETTING PARAMETERS

qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0.9; id='I001_P005_D01'; seg = '1';
chNum = 1; szPoint = 25220; szPointF = 25290.5; szStart = 451;
sampRate = 5000; segmentSize = 1024; tWindow = segmentSize/sampRate;

szStop = szStart + szPointF - szPoint;

%% FILTERING DELTA-POWER BAND

% window = 512;
% noverlap = window/2;
% nfft = 256;
% fs = 512;
% 
% spectrogram(data, window, noverlap, nfft, fs,'yaxis')

[b,a] = butter(2, 0.5/(sampRate/2), 'high');
data = filtfilt(b,a,double(values));

% [b,a] = butter(2, 4/(sampRate/2), 'low');
% data = filtfilt(b,a,double(data));

%% FILTERING COMPONENTS OF FREQUENCIES BELLOW 1 Hz TO REMOVE DC SHIFTS

% [b,a] = butter(2, 1/(sampRate/2), 'high');
% data = filtfilt(b,a,values);

% data = downsample(data,2);
% sampRate = 2500;
% tWindow = segmentSize/sampRate;

%% MULTIFRACTAL SPECTRA (NORMALISED PER EPOCH)

segmentSize = sampRate*tWindow;
siz = floor(length(data)/segmentSize)*segmentSize;
data = data(1:siz,1);

[chj.deltaF,chj.width] = ...
    chj_nr_meth(data',segmentSize,qi,qf,dq,Np,Ra,Io);


%% STANDARD DEVIATION AND MEAN

[~,~,dStat] = mstdvar(data',tWindow,sampRate);

%pBandMat = powerBands(data,sampRate,tWindow);
%% LINE LENGTH

ll = llength(data',sampRate,tWindow);


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
xlim([400 600])
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
xlim([400 600])
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
xlim([400 600])
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
xlim([400 600])
ylim([min(ll) max(ll)])
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