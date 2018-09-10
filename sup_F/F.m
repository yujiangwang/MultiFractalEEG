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
% Authors: Lucas FranÃ§a(1), Yujiang Wang(1,2,3)
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

electr = data(1:1024);
x = (electr - mean(electr))/std(electr);
sigma = 1./(1 + exp(-x));

colours = [[108,55,153];
[93,185,203];
[130,0,191];
[0,115,119];
[255,28,158];
[80,181,239];
[214,1,146];
[117,180,210];
[116,69,242];
[71,82,99];
[2,66,233];
[187,137,152];
[69,108,255];
[209,131,155];
[0,131,255];
[169,0,106];
[1,144,234];
[255,104,222];
[1,112,167];
[250,135,189];
[8,73,181];
[178,82,116];
[211,122,255];
[159,172,198];
[143,23,134];
[64,80,119];
[246,134,211];
[73,73,143];
[226,141,233];
[126,56,99];
[198,159,206]]/255;

scales = 2.^(Io:Np);

% CHHABRA-JENSEN METHOD CALL
[n,Fq,tau,alpha,f] = MFDMA_1D(sigma,2^Io,2^Np,7,0,qi:dq:qf);

figure
hold on

for p = 1:(length(qi:dq:qf))
    
    plot(log(scales),log(Fq(:,p)),'Color',colours(p,:),'LineWidth', 1)
    
end

[Hq,tq,hq,Dq,Fq] = MFDFA1(sigma,Io:Np,qi:dq:qf,1,0);

Fq = Fq';

figure
hold on

for p = 1:(length(qi:dq:qf))
    
    plot(log(scales),log(Fq(:,p)),'Color',colours(p,:),'LineWidth', 1)
    
end