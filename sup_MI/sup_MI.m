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

%checked by YW 25th July 2017
clear
close all
addpath(genpath('../libs/'))

%% OPENING THE DATA

load('JR_12062011_1630_1730_ch1.mat');

%% SETTING PARAMETERS

tWindow = 2; segmentSize = 1024; qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0;
sampRate = 512;

%% MULTIFRACTAL SPECTRA (NORMALISED PER EPOCH)

[chj.deltaF,chj.width] = ...
    chj_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io);

%% MULTIFRACTAL SPECTRA (NORMALISED ON THE WHOLE DATA SERIES)
%note that Chhabra Jensen only accepts positive values as input time
%series, hence the sigmoid transform is neccessary in any case

x = (data - mean(data))/std(data);
sigma = 1./(1 + exp(-x));

[chjAll.deltaF,chjAll.width] = ...
    chj_nr_meth_n(sigma,segmentSize,qi,qf,dq,Np,Ra,Io);

%% STANDARD DEVIATION AND MEN

[~,~,dStat] = mstdvar(data,tWindow,sampRate);

%pBandMat = powerBands(data,sampRate,tWindow);
%% LINE LENGTH

ll = llength(data,sampRate,tWindow);


%% MERGING AND EXPORTING THE MEASURES

bMat = horzcat(chjAll.width(:,2),chjAll.deltaF(:,2),chj.width(:,2),...
    chj.deltaF(:,2),dStat,ll);

save('bMat.mat','bMat')

MI = zeros(size(bMat,2));

for k = 1:size(bMat,2)
    
    for j = 1:size(bMat,2)
        
        if k == j
            
            MI(k,j) = NaN;
            
        else
        
            MI(k,j) = gcmi_cc(bMat(:,k),bMat(:,j));
        
        end
        
    end
    
end

save('MI.mat','MI')