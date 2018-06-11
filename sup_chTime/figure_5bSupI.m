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
close all
addpath(genpath('../libs/'))
addpath(genpath('../data/'))

%% DEFINING PARAMETERS

id = 'I001_P010_D01';

szPoint = 25220; szPointF = 25290.5; nullPoint = szPoint - 1800;
nullPointF = szPointF - 1800; sampRate = 5000;


%% iEEG.ORG SESSION (PLEASE REPLACE xxx WITH YOUR DETAILS)
% 
% session = IEEGSession(id,xxx,xxx);
% sampRate = session.data.sampleRate;
% 
% segStart = nullPoint * sampRate;
% segStop = nullPointF * sampRate;
% values = session.data.getvalues(segStart:segStop,...
%     1:length(session.data.channelLabels(:,1)));
% 
% segStart = szPoint * sampRate;
% segStop = szPointF * sampRate;
% valuesSz = session.data.getvalues(segStart:segStop,...
%     1:length(session.data.channelLabels(:,1)));
% 
% save('figure_5bSupI.mat','values','valuesSz')

load('figure_5bSupI.mat')

%% LOOP OVER THE CHANNELS OF INTEREST (SOZ channels)

for chNum = [5,6,20]

    % SEIZURE SEGMENTS

    szRaw{1} = valuesSz(:,chNum);

    % CHANNELS ARE RESAMPLE ARE RESAMPLED IN ORDER TO EVALUATE INTERMEDIARY
    % TIME SCALES

    szRawi{1} = resample(valuesSz(:,chNum),6,5);
    szRawi2{1} = resample(valuesSz(:,chNum),4,5);

    % INTERICTAL SEGMENTS

    nullRaw{1} = values(:,chNum);
    nullRawi{1} = resample(values(:,chNum),6,5);
    nullRawi2{1} = resample(values(:,chNum),4,5);

    % NUMBER OF SEIZURES

    szNum = 1:length(szRaw);

    % WINDOW LENGTHS STUDIED

    wSizes = [1024, 2048, 4096, 8192];

    % SAMPLING RATES STUDIED

    sampRates = [5000, 2500, 1000, 500, 250];

    % EVALUATION OF THE TIME SCALES FOR THE ORIGINAL SIGNAL

    filename = ['effSize_' id '_ch_' num2str(chNum)];
    swSpotEval(szRaw,nullRaw,filename,wSizes,szNum,...
        5000,sampRates,-15,15,1,2,8,0.9);

    % WINDOW LENGTHS STUDIED

    wSizes = [1024, 2048, 4096, 8192];

    % SAMPLING RATES STUDIED

    sampRates = [3000,2000,1500,1200,750,600,300];

    % EVALUATION OF THE TIME SCALES FOR THE RESAMPLED SIGNAL

    filename = ['effSize_i' id '_ch_' num2str(chNum)];
    swSpotEval(szRawi,nullRawi,filename,wSizes,szNum,...
        6000,sampRates,-15,15,1,2,8,0.9);

    % WINDOW LENGTHS STUDIED

    wSizes = [1024, 2048, 4096, 8192];

    % SAMPLING RATES STUDIED

    sampRates = [4000,800,400];

    % EVALUATION OF TEH TIME SCALES FOR THE RESAMPLED SIGNAL

    filename = ['effSize_i2' id '_ch_' num2str(chNum)];
    swSpotEval(szRawi2,nullRawi2,filename,wSizes,szNum,...
        4000,sampRates,-15,15,1,2,8,0.9);

end
