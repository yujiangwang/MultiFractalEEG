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

% checked by YW on 22nd July

clear
close all
addpath(genpath('../libs/'))

%% DEFINING PARAMETERS OF MULTIFRACATAL ANALYSIS
segmentSize = 1024; qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0;

%% GENERATING A MULTIFRACTAL PROFILE WITH p-MODEL

% THE GENERATED DATA HAS 64 EPOCHS WITH THE segmentSize AND p = 0.4
data = pmodel(segmentSize*64, 0.4);

%% ESTIMATING THE MULTIFRACTAL SPECTRA

% WITH SIGMOID TRANSFORMATION

[mfdfa.deltaF,mfdfa.width] = ...
    mfdfa_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io);
[mfdma.deltaF,mfdma.width] = ...
    mfdma_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io);
[chj.deltaF,chj.width] = ...
    chj_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io);

% WITHOUT SIGMOID TRANSFORMATION

[mfdfaN.deltaF,mfdfaN.width] = ...
    mfdfa_nr_meth_n(data,segmentSize,qi,qf,dq,Np,Ra,Io);
[mfdmaN.deltaF,mfdmaN.width] = ...
    mfdma_nr_meth_n(data,segmentSize,qi,qf,dq,Np,Ra,Io);
[chjN.deltaF,chjN.width] = ...
    chj_nr_meth_n(data,segmentSize,qi,qf,dq,Np,Ra,Io);


%% FIGURE OF THE VARIATION OF THE MULTIFRACTAL SPECTRA WIDTH (W/ SIGMOID)

h = figure;
hold on

plot(2:2:2*length(mfdfa.width(:,2)),mfdfa.width(:,2),...
    'Color',[202 0 32]./255,'LineWidth',3)
plot(2:2:2*length(mfdma.width(:,2)),mfdma.width(:,2),...
    'Color',[146 197 222]./255,'LineWidth',3)
plot(2:2:2*length(chj.width(:,2)),chj.width(:,2),...
    'Color',[5 113 176]./255,'LineWidth',3)

hold off

lgd = legend('MF-DFA*','MF-DMA*','Chhabra-Jensen*','location','best');
lgd.FontSize = 14;
xlabel('Time (s)')
ylabel('\Delta\alpha')
box on
xlim([2 2*length(mfdfa.width(:,2))])
ylim([0.1 1.1])
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)
ttl = title('Multifractal spectra width (sigmoid) | p-Model (p = 0.4)');
ttl.FontSize = 16;

print -depsc2 -painters meth_pModel_comp_sig_width_unfilt.eps
print -dpng meth_pModel_comp_sig_width_unfilt.png





%% FIGURE OF THE VARIATION OF THE MULTIFRACTAL SPECTRA WIDTH

h = figure;
hold on

plot(2:2:2*length(mfdfaN.width(:,2)),mfdfaN.width(:,2),':',...
    'Color',[202 0 32]./255,'LineWidth',3)
plot(2:2:2*length(mfdmaN.width(:,2)),mfdmaN.width(:,2),':',...
    'Color',[146 197 222]./255,'LineWidth',3)
plot(2:2:2*length(chjN.width(:,2)),chjN.width(:,2),':',...
    'Color',[5 113 176]./255,'LineWidth',3)

hold off

lgd = legend('MF-DFA','MF-DMA','Chhabra-Jensen','location','best');
lgd.FontSize = 14;
xlabel('Time (s)')
ylabel('\Delta\alpha')
box on
xlim([2 2*length(mfdfa.width(:,2))])
ylim([0.1 1.1])
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)
ttl = title('Multifractal spectra width | p-Model (p = 0.4)');
ttl.FontSize = 16;

print -depsc2 -painters meth_pModel_comp_width_unfilt.eps
print -dpng meth_pModel_comp_width_unfilt.png

%% FIGURE OF THE VARIATION OF THE MULTIFRACTAL SPECTRA HEIGHT (W/ SIGMOID)

h = figure;
hold on

plot(2:2:2*length(mfdfa.deltaF(:,2)),mfdfa.deltaF(:,2),...
    'Color',[202 0 32]./255,'LineWidth',3)
plot(2:2:2*length(mfdma.deltaF(:,2)),mfdma.deltaF(:,2),...
    'Color',[146 197 222]./255,'LineWidth',3)
plot(2:2:2*length(chj.deltaF(:,2)),chj.deltaF(:,2),...
    'Color',[5 113 176]./255,'LineWidth',3)

hold off

lgd = legend('MF-DFA*','MF-DMA*','Chhabra-Jensen*','location','best');
lgd.FontSize = 14;
xlabel('Time (s)')
ylabel('\Deltaf')
box on
xlim([2 2*length(mfdfa.deltaF(:,2))])
ylim([0.1 3.4])
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)
ttl = title('Multifractal spectra height (sigmoid) | p-Model (p = 0.4)');
ttl.FontSize = 16;


print -depsc2 -painters meth_pModel_comp_sig_deltaF_unfilt.eps
print -dpng meth_pModel_comp_sig_deltaF_unfilt.png


%% FIGURE OF THE VARIATION OF THE MULTIFRACTAL SPECTRA HEIGHT

h = figure;
hold on

plot(2:2:2*length(mfdfaN.deltaF(:,2)),mfdfaN.deltaF(:,2),':',...
    'Color',[202 0 32]./255,'LineWidth',3)
plot(2:2:2*length(mfdmaN.deltaF(:,2)),mfdmaN.deltaF(:,2),':',...
    'Color',[146 197 222]./255,'LineWidth',3)
plot(2:2:2*length(chjN.deltaF(:,2)),chjN.deltaF(:,2),':',...
    'Color',[5 113 176]./255,'LineWidth',3)

hold off

lgd = legend('MF-DFA','MF-DMA','Chhabra-Jensen','location','best');
lgd.FontSize = 14;
xlabel('Time (s)')
ylabel('\Deltaf')
box on
xlim([2 2*length(mfdfa.deltaF(:,2))])
ylim([0.1 3.4])
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)
ttl = title('Multifractal spectra height | p-Model (p = 0.4)');
ttl.FontSize = 16;


print -depsc2 -painters meth_pModel_comp_deltaF_unfilt.eps
print -dpng meth_pModel_comp_deltaF_unfilt.png
