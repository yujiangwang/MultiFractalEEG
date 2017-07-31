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

%checked by YW 26th July 2017
clear
close all

%% EVALUATION PARAMETERS

qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0.9; id='I001_P005_D01';
sampRate = 5000;

%% iEEG.ORG SESSION (PLEASE REPLACE xxx WITH YOUR DETAILS)

% session = IEEGSession(id,'lucasfr','luc_ieeglogin.bin');
%
% Channels = session.data.channelLabels;
%
% sampRate = session.data.sampleRate;
% nCh=length(Channels);
%
% szPoint = 25220;
% szStart = 901;
% szStop = szStart + 25290.5 - szPoint;
%
% values = session.data.getvalues((szPoint-900)*sampRate:...
%     (szPoint+900)*sampRate, 2);
%
%
% save('figure_7.mat','values')

%% LOADING DATA (YOU CAN ALSO DOWNLOAD IT FROM iEEG.ORG - JUST UNCOMMENT)

load('figure_7.mat')

%% BANDPASS FILTER
%to remove DC shifts below 0.5 Hz
%not notch filter applied, as line noise was not too bad in this segment

[b,a] = butter(2, [0.5 500]/(sampRate/2), 'bandpass');
values = filtfilt(b,a,values);

%% CROPPING THE DATA INTO A LENGTH COMPATIBLE TO THE DYADIC SCALE

siz = floor(length(values)/8192)*8192;
data = values(1:siz);
data = data';

%% CHHABRA-JENSEN METHOD

[deltaF,width] = ...
    chj_nr_meth(data,8192,qi,qf,dq,Np,Ra,Io);

%% BANDPASS FILTER TO REMOVE DC shifts

[b,a] = butter(2, [0.5 500]/(sampRate/2), 'bandpass');
values = filtfilt(b,a,values);

%% POWER SPECTRUM FUNCTION

[pBandMat] = powerBands(data,5000,8192);

%% CREATING DATA MATRIX

bMat = horzcat(width(:,2),deltaF(:,2),pBandMat(:,1:5));

save('iEEG_pBands.mat','bMat')
