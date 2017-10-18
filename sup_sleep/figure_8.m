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

%Checked by YW on 27th July
clear
close all
addpath(genpath('~/GitHub/MultiFractalEEG/libs/'))

%% DEFINING PARAMETERS
segmentSize = 1024; qi = -15; qf = 15; dq = 1; Io = 2; Np = 8; Ra = 0.9;
sampRate = 100; factor = segmentSize/sampRate;

%% LOADING DATA
load('ST7011J.mat');

%% CONVERTING MARKINGS INTO A HYPNOGRAM
ann = annExpndr(annot,onset,sData,sampRate);

%% PERFORMING THE DATA ANALYSIS
[cz,oz] = sleepEval(ann,sData,segmentSize,sampRate,qi,qf,dq,Np,Ra,Io);

%% PREPARING DATA AND EXPORTING
[classANOVA] = classDSamp(ann,cz.width(:,2),factor);
bMat = horzcat(classANOVA,cz.width(:,2),cz.deltaF(:,2),cz.deltaPR,...
    oz.width(:,2),oz.deltaF(:,2),oz.deltaPR);

save('sleep_ST7011J.mat','bMat');
