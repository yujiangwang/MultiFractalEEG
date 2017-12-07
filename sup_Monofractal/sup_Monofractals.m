% Authors: Lucas Fran�a(1), Yujiang Wang(1,2,3)

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

segSize = 1024;

%% DFA AND DESCRIPTIVE STATISTICS

tic
[dfaFD] = dfa_nr_meth(data,segSize,8,2); % 2 - dyadic scale
toc
tic
[dfaFDn] = dfa_nr_meth_n(data,segSize,8,2);
toc
tic
[mVal,stdVal,~] = mstdvar(data,2,512);
toc


%% HIGUCHI METHOD
tic
[HigFD] = higuchi_nr_meth(data,segSize,4);
toc
[HigFDn] = higuchi_nr_meth_n(data,segSize,4);

%% SAVING OUTPUTS

save('monofractal.mat','dfaFD','dfaFDn','mVal','stdVal','HigFD','HigFDn')


%% PLOTTING THE FIGURES
