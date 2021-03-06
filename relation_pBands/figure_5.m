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

%checked by YW 26th July 2017
clear
close all

addpath(genpath('../libs/'))
addpath(genpath('../data/'))

%% EVALUATION PARAMETERS

qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0.9; id='JR_12062011_1630_1730_ch1';
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

load('JR_12062011_1630_1730_ch1.mat')

%% BANDPASS FILTER
%to remove DC shifts below 0.5 Hz
%not notch filter applied, as line noise was not too bad in this segment

[b,a] = butter(2, [0.5 512]/(sampRate/2), 'bandpass');
values = filtfilt(b,a,double(data));

%% CROPPING THE DATA INTO A LENGTH COMPATIBLE TO THE DYADIC SCALE

siz = floor(length(values)/8192)*8192;
data = values(1:siz);
data = data';

%% CHHABRA-JENSEN METHOD

[deltaF,width] = ...
    chj_nr_meth(data',1024,qi,qf,dq,Np,Ra,Io);

%% POWER SPECTRUM FUNCTION

[pBandMat] = powerBands(data,512,1024);

%% CREATING DATA MATRIX

bMat = horzcat(width(:,2),deltaF(:,2),pBandMat(:,1:5));

save('iEEG_pBands.mat','bMat')
