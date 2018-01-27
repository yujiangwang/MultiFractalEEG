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

% checked by YW on 22nd July 2017

clear
close all
addpath(genpath('../libs/'))
%% SETTING PARAMETERS

qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0.9; id='I001_P005_D01'; seg = '1';
chNum = 1; szPoint = 25220; szPointF = 25290.5; szStart = 451;
sampRate = 5000;

szStop = szStart + szPointF - szPoint;

%% iEEG.ORG SESSION (PLEASE REPLACE xxx WITH YOUR DETAILS)

% session = IEEGSession(id,'xxx','xxx');
%
% Channels = session.data.channelLabels;
% sampRate = session.data.sampleRate;
% nCh=length(Channels);
% values = session.data.getvalues((szPoint-450)*sampRate:...
%     (szPoint+450)*sampRate, chNum);
%
% save('figure_5a.mat','values')

load('figure_5a.mat')%to save downloading frm the iEEG portal, we provide the data we used as a mat file

%% FILTERING COMPONENTS OF FREQUENCIES BELLOW 1 Hz TO REMOVE DC SHIFTS

[b,a] = butter(2, 1/(sampRate/2), 'high');
        values = filtfilt(b,a,values);


%% ESTIMATING THE MULTIFRACTAL SPECTRA

% THIS SEGMENT OF THE CODE PERFORMS SUCESSIVE ChJ OPERATIONS WITH DIFFERENT
% WINDOW LENGTHS AND DOWNSAMPLINGS AND SHOULD TAKE A WHILE. SIGNALS WITH
% DIFFERENT SAMPLING RATES SHOULD HAVE THE FOLLOWING SECTION ADAPTED
% ACCORDING TO THE ORIGINAL SAMPLING FREQUENCY.

%% 5000Hz

tWindow = 1024/5000;

siz = floor(length(values)/16384)*16384;%2^14=16384, which is the largest number of points that will use used in the following for the estimation of the MF spectrum
data = values(1:siz,1)';

[w1.deltaF,w1.width] = ...
    chj_nr_meth(data,1024,qi,qf,dq,Np,Ra,Io);%2^10

[~,~,dStat] = mstdvar(data,tWindow,sampRate);

figure

plot(tWindow:tWindow:(tWindow*length(w1.width(:,2))),w1.width(:,2),...
    'LineWidth',2)

hold on
plot([szStart szStart],[min(w1.width(:,2)) max(w1.width(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[min(w1.width(:,2)) max(w1.width(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
hold off

ylim([min(w1.width(:,2)) max(w1.width(:,2))])

xlabel('Time (s)')
ylabel('\Delta\alpha*')

title('Multifractal spectra width')

figure

plot(tWindow:tWindow:(tWindow*length(dStat(:,2))),dStat(:,2),...
    'LineWidth',2)

hold on
plot([szStart szStart],[min(dStat(:,2)) max(dStat(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[min(dStat(:,2)) max(dStat(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
hold off

ylim([min(dStat(:,2)) max(dStat(:,2))])

xlabel('Time (s)')
ylabel('\sigma')

title('Standard deviation')

figure

plot(tWindow:tWindow:(tWindow*length(w1.width(:,2))),...
    smoothdata(w1.width(:,2),'movmedian',100),'LineWidth',2)

hold on
plot([szStart szStart],[min(w1.width(:,2)) max(w1.width(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[min(w1.width(:,2)) max(w1.width(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
hold off

ylim([min(w1.width(:,2)) max(w1.width(:,2))])

xlabel('Time (s)')
ylabel('\Delta\alpha*')

title('Multifractal spectra width (smoothed)')

figure

plot(tWindow:tWindow:(tWindow*length(dStat(:,2))),...
    smoothdata(dStat(:,2),'movmedian',100),'LineWidth',2)

hold on
plot([szStart szStart],[min(dStat(:,2)) max(dStat(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[min(dStat(:,2)) max(dStat(:,2))],'Color',...
    [202 0 32]./255, 'LineWidth',2)
hold off

ylim([min(dStat(:,2)) max(dStat(:,2))])

xlabel('Time (s)')
ylabel('\sigma')

title('Standard deviation (smoothed)')

figure
[values, centers] = hist3([w1.width(:,2) dStat(:,2)],[70 70]);
imagesc(centers{:},values.')
colorbar
axis xy
xlabel('\Delta\alpha*')
ylabel('St. Dev.')
ylim([5 200])
xlim([0.01 0.5])
set(gca,'FontSize',18,'FontName','Times')


