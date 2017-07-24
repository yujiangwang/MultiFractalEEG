clear
close all

%% EVALUATION PARAMETERS

qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0.9; id='I001_P005_D01';

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
% save('figure_6.mat','values')

%% LOADING DATA (YOU CAN ALSO DOWNLOAD IT FROM iEEG.ORG - JUST UNCOMMENT)

load('figure_6.mat')

%% BANDPASS FILTER

[b,a] = butter(2, [0.5 500]/(sampRate/2), 'bandpass');
values = filtfilt(b,a,values);

%% CROPPING THE DATA INTO A LENGTH COMPATIBLE TO TEH DYADIC SCALE

siz = floor(length(values)/8192)*8192;
data = values(1:siz);
data = data';

%% CHHABRA-JENSEN METHOD

[deltaF,width] = ...
    chj_nr_meth(data,8192,qi,qf,dq,Np,Ra,Io);

%% BANDPASS FILTER

[b,a] = butter(2, [0.5 500]/(sampRate/2), 'bandpass');
values = filtfilt(b,a,values);

%% POWER SPECTRUM FUNCTION

[pBandMat] = powerBands(data,5000,8192);

%% CREATING DATA MATRIX

bMat = horzcat(width(:,2),deltaF(:,2),pBandMat(:,1:5));

save('iEEG_pBands.mat','bMat')