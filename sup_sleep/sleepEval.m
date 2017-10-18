function [cz,oz] = sleepEval(ann,sData,segmentSize,sampRate,qi,qf,dq,Np,Ra,Io)
%this script calculates the Chhabra Jensen multifractal spectrum on the cz
%and oz channels in the EEG recording and plot this with the hypnogram and
%the delta bandpower 

%% PARAMETERS

% FACTOR IS THE RATIO BETWEEN THE EEG SAMPLING RATE AND THE MULTIFRACTAL
% METRIC SAMPLNG RATE.

factor = segmentSize/sampRate;

%% CROPPING THE TIME SERIES TO A DYADIC SCALE COMPATIBLE LENGTH

data = sData(1,:);
siz = floor(length(sData)/segmentSize)*segmentSize;
data = data(1,1:siz);

%% MULTIFRACTAL AND DELTA ANALYSES FROM ONE OF THE CHANNELS

[cz.deltaF,cz.width] = ...
    chj_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io);
[cz.deltaPR] = deltaBand(data,sampRate,segmentSize);

%% CROPPING THE TIME SERIES TO A DYADIC SCALE COMPATIBLE LENGTH

data = sData(2,:);
siz = floor(length(sData)/segmentSize)*segmentSize;
data = data(1,1:siz);

%% MULTIFRACTAL AND DELTA ANALYSES FROM ONE OF THE CHANNELS

[oz.deltaF,oz.width] = ...
    chj_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io);
[oz.deltaPR] = deltaBand(data,sampRate,segmentSize);

%% PLOTTING THE FIGURES

figure;
subplot(3,1,1)
plot(cz.width(:,1)*factor,cz.width(:,2),'Color',[202 0 32]./255,...
    'LineWidth',2)
hold on
plot(cz.width(:,1)*factor,oz.width(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
title('Multifractal spectra width')
xlabel('Time (s)')
ylabel('\Delta\alpha')
legend('Fpz-Cz','Pz-Oz')
xlim([factor factor*cz.width(end,1)])
ylim([min([min(cz.width(:,2)) min(oz.width(:,2))]) 0.7])
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)
hold off

subplot(3,1,2)
plot(cz.width(:,1)*factor,cz.deltaPR,'Color',[202 0 32]./255,...
    'LineWidth',2)
hold on
plot(cz.width(:,1)*factor,oz.deltaPR,'Color',[5 113 176]./255,...
    'LineWidth',2)
title('Power in \delta-band')
xlabel('Time (s)')
ylabel('P(\delta)')
legend('Fpz-Cz','Pz-Oz')
xlim([factor factor*cz.width(end,1)])
ylim([0 1])
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)
hold off

subplot(3,1,3)
plot(ann,'k','LineWidth',2)
title('Hypnogram')
xlim([factor factor*cz.width(end,1)])
ylim([-6 -1])
xlabel('Time (s)')
set(gca, 'YTick', -6:-1, 'YTickLabel', {'S4' 'S3' 'S2' 'S1' 'REM' 'Wake'})
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)


figure;
subplot(3,1,1)
plot(cz.width(:,1)*factor,cz.deltaF(:,2),'Color',[202 0 32]./255,...
    'LineWidth',2)
hold on
plot(cz.width(:,1)*factor,oz.deltaF(:,2),'Color',[5 113 176]./255,...
    'LineWidth',2)
title('Multifractal spectra height')
xlabel('Time (s)')
ylabel('\Deltaf')
legend('Fpz-Cz','Pz-Oz')
xlim([factor factor*cz.width(end,1)])
ylim([min([min(cz.width(:,2)) min(oz.width(:,2))]) 0.8])
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)
hold off

subplot(3,1,2)
plot(cz.width(:,1)*factor,cz.deltaPR,'Color',[202 0 32]./255,...
    'LineWidth',2)
hold on
plot(cz.width(:,1)*factor,oz.deltaPR,'Color',[5 113 176]./255,...
    'LineWidth',2)
title('Power in \delta-band')
xlabel('Time (s)')
ylabel('P(\delta)')
legend('Fpz-Cz','Pz-Oz')
xlim([factor factor*cz.width(end,1)])
ylim([0 1])
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)
hold off

subplot(3,1,3)
plot(ann,'k','LineWidth',2)
title('Hypnogram')
xlim([factor factor*cz.width(end,1)])
ylim([-6 -1])
xlabel('Time (s)')
set(gca, 'YTick', -6:-1, 'YTickLabel', {'S4' 'S3' 'S2' 'S1' 'REM' 'Wake'})
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)

% print -depsc2 -painters sleep_ST7011J.eps
% print -dpng sleep_ST7011J.png
end
