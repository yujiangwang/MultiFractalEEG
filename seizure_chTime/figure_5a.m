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
addpath(genpath('~/GitHub/MultiFractalEEG/libs/'))
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

siz = floor(length(values)/16384)*16384;%2^14=16384, which is the largest number of points that will use used in the following for the estimation of the MF spectrum
data = values(1:siz,1)';

[w1.deltaF,w1.width] = ...
    chj_nr_meth(data,1024,qi,qf,dq,Np,Ra,Io);%2^10
[w2.deltaF,w2.width] = ...
    chj_nr_meth(data,2048,qi,qf,dq,Np,Ra,Io);%2^11
[w3.deltaF,w3.width] = ...
    chj_nr_meth(data,4096,qi,qf,dq,Np,Ra,Io);%2^12
[w4.deltaF,w4.width] = ...
    chj_nr_meth(data,8192,qi,qf,dq,Np,Ra,Io);%2^13
[w5.deltaF,w5.width] = ...
    chj_nr_meth(data,16384,qi,qf,dq,Np,Ra,Io);%2^15


%% 2500Hz

values2500 = downsample(values,2);

siz = floor(length(values2500)/16384)*16384;
data = values2500(1:siz,1)';

[w1.deltaF2500,w1.width2500] = ...
    chj_nr_meth(data,1024,qi,qf,dq,Np,Ra,Io);
[w2.deltaF2500,w2.width2500] = ...
    chj_nr_meth(data,2048,qi,qf,dq,Np,Ra,Io);
[w3.deltaF2500,w3.width2500] = ...
    chj_nr_meth(data,4096,qi,qf,dq,Np,Ra,Io);
[w4.deltaF2500,w4.width2500] = ...
    chj_nr_meth(data,8192,qi,qf,dq,Np,Ra,Io);
[w5.deltaF2500,w5.width2500] = ...
    chj_nr_meth(data,16384,qi,qf,dq,Np,Ra,Io);


%% 500Hz

values500 = downsample(values,10);

siz = floor(length(values500)/16384)*16384;
data = values500(1:siz,1)';

[w1.deltaF500,w1.width500] = ...
    chj_nr_meth(data,1024,qi,qf,dq,Np,Ra,Io);
[w2.deltaF500,w2.width500] = ...
    chj_nr_meth(data,2048,qi,qf,dq,Np,Ra,Io);
[w3.deltaF500,w3.width500] = ...
    chj_nr_meth(data,4096,qi,qf,dq,Np,Ra,Io);
[w4.deltaF500,w4.width500] = ...
    chj_nr_meth(data,8192,qi,qf,dq,Np,Ra,Io);
[w5.deltaF500,w5.width500] = ...
    chj_nr_meth(data,16384,qi,qf,dq,Np,Ra,Io);

%% 100Hz

values100 = downsample(values,50);

siz = floor(length(values100)/16384)*16384;
data = values100(1:siz,1)';

[w1.deltaF100,w1.width100] = ...
    chj_nr_meth(data,1024,qi,qf,dq,Np,Ra,Io);
[w2.deltaF100,w2.width100] = ...
    chj_nr_meth(data,2048,qi,qf,dq,Np,Ra,Io);
[w3.deltaF100,w3.width100] = ...
    chj_nr_meth(data,4096,qi,qf,dq,Np,Ra,Io);
[w4.deltaF100,w4.width100] = ...
    chj_nr_meth(data,8192,qi,qf,dq,Np,Ra,Io);
[w5.deltaF100,w5.width100] = ...
    chj_nr_meth(data,16384,qi,qf,dq,Np,Ra,Io);

%% PLOTING THE MULTIFRACTAL SPECTRA WITH FOR THE DIFFERENT ChJ SETTINGS

figure();
subplot(5,4,1)
plot((1024/5000)*w1.width(:,1),w1.width(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('5000Hz - 1024 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,2)
plot((1024/2500)*w1.width2500(:,1),w1.width2500(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('2500Hz - 1024 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,3)
plot((1024/500)*w1.width500(:,1),w1.width500(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('500Hz - 1024 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,4)
plot((1024/100)*w1.width100(:,1),w1.width100(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('100Hz - 1024 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,5)
plot((2048/5000)*w2.width(:,1),w2.width(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('5000Hz - 2048 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,6)
plot((2048/2500)*w2.width2500(:,1),w2.width2500(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('2500Hz - 2048 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,7)
plot((2048/500)*w2.width500(:,1),w2.width500(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('500Hz - 2048 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,8)
plot((2048/100)*w2.width100(:,1),w2.width100(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('100Hz - 2048 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,9)
plot((4096/5000)*w3.width(:,1),w3.width(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('5000Hz - 4096 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,10)
plot((4096/2500)*w3.width2500(:,1),w3.width2500(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('2500Hz - 4096 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,11)
plot((4096/500)*w3.width500(:,1),w3.width500(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('500Hz - 4096 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,12)
plot((4096/100)*w3.width100(:,1),w3.width100(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('100Hz - 4096 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,13)
plot((8192/5000)*w4.width(:,1),w4.width(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('5000Hz - 8192 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,14)
plot((8192/2500)*w4.width2500(:,1),w4.width2500(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('2500Hz - 8192 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,15)
plot((8192/500)*w4.width500(:,1),w4.width500(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('500Hz - 8192 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,16)
plot((8192/100)*w4.width100(:,1),w4.width100(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('100Hz - 8192 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,17)
plot((16384/5000)*w5.width(:,1),w5.width(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('5000Hz - 16384 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,18)
plot((16384/2500)*w5.width2500(:,1),w5.width2500(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('2500Hz - 16384 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,19)
plot((16384/500)*w5.width500(:,1),w5.width500(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('500Hz - 16384 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)
subplot(5,4,20)
plot((16384/100)*w5.width100(:,1),w5.width100(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
hold on
plot([szStart szStart],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
plot([szStop szStop],[0 1],'Color',[202 0 32]./255, 'LineWidth',2)
hold off
ylim([0 1])
xlim([0 900])
xlabel('Time (s)')
ylabel('\Delta\alpha')
title('100Hz - 16384 p')
set(gca,'FontSize',12,'FontName','Times','LineWidth',1.5)


set(gcf, 'Position', get(0, 'Screensize'));

print(['windowTestIEEG_' id '_' seg],'-depsc2','-painters')
print(['windowTestIEEG_' id '_' seg],'-dpng','-r600')
