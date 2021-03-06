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

%% Results successfully reproduced by YW (20/July/2017)
%% External function such as dfa() and Higuchi_FD() were not checked in detail
clear
close all
clc
addpath(genpath('../libs/'))

%% PARAMETERS

stdFactor = [0.5, 0.1, 0.05, 0.01, 0.005, 0.001]; segSize = 1024;

%% CREATING ARRAYS

dfaFD = zeros(1800,length(stdFactor));
dfaFDn = zeros(1800,length(stdFactor));
stdVal = zeros(1800,length(stdFactor));
mVal = zeros(1800,length(stdFactor));
stdPat = ones(1800,length(stdFactor));
series = zeros(1800*segSize,length(stdFactor));


for j = 1:length(stdFactor)


    io = 450;
    iSz = 900;

    %% STANDARD DEVIATION FUNCTION

    for i = io:iSz

        stdPat(i,j) = stdPat(i,j) + stdFactor(j)*(i-io);

    end

    %% TWEAKED FRACTIONAL BROWNIAN MOTION

    for i = 1:1800

        if i == 1

            [W] = tweakedFBM(segSize,0.7,0,i,stdPat(i,j));

        else

            [W] = tweakedFBM(segSize,0.7,W(1025),i,stdPat(i,j));

        end

        series((1+(segSize*(i-1))):(segSize+(segSize*(i-1))),j) =...
            W(1:segSize);
     end

end

%% DFA AND DESCRIPTIVE STATISTICS

%can use parfor
for j = 1:length(stdFactor)
    tic
    [dfaFD(:,j)] = dfa_nr_meth(series(:,j)',segSize,8,2); % 2 - dyadic scale
    toc
    tic
    [dfaFDn(:,j)] = dfa_nr_meth_n(series(:,j)',segSize,8,2);
    toc
    tic
    [mVal(:,j),stdVal(:,j),~] = mstdvar(series(:,j)',2,512);
    toc

end

%% HIGUCHI METHOD
tic
[HigFD] = higuchi_nr_meth(series(:,4)',segSize,4);
toc
[HigFDn] = higuchi_nr_meth_n(series(:,4)',segSize,4);


% %% PLOTTING THE FIGURES
% 
% h = figure;
% 
% window = segSize;
% noverlap = window/2;
% nfft = 256;
% fs = 512;
% 
% spectrogram(series(:,4), window, noverlap, nfft, fs,'yaxis');
% colormap(parula)
% ylim([0 128])
% 
% set(gca,'FontSize',20,'FontName','Times')
% set(gca,'LineWidth',1.5)
% 
% print -depsc2 -painters fract_spectr.eps
% print -dpng fract_spectr.png


fractalsMat = horzcat(dfaFD(:,4),dfaFDn(:,4),HigFD,HigFDn,stdVal(:,4),...
    mVal(:,4));

save('fractalsl.mat','fractalsMat','dfaFD','dfaFDn','series')


figure

subplot(2,1,1)
plot(2:2:2*length(dfaFD(:,4)),dfaFD(:,4),'Color',[202 0 32]./255,...
    'LineWidth',1)
hold on
plot(2:2:2*length(smoothdata(dfaFD(:,4),'movmedian',50)),...
    smoothdata(dfaFD(:,4),'movmedian',50),'Color',[0 0 0]./255,'LineWidth',2)
hold off
title('Variation of scaling exponent (with standardisation and sigmoid)')
xlim([2 3600])
ylim([1.3 1.9])
xlabel('Time (s)')
ylabel('h_{DFA}')
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)

subplot(2,1,2)
plot(2:2:2*length(dfaFDn(:,4)),dfaFDn(:,4),'Color',[5 113 176]./255,...
    'LineWidth',1)
hold on
plot(2:2:2*length(smoothdata(dfaFDn(:,4),'movmedian',50)),...
    smoothdata(dfaFDn(:,4),'movmedian',50),'Color',[0 0 0]./255,'LineWidth',2)
hold off
title('Variation of scaling exponent')
xlim([2 3600])
ylim([1.3 1.9])
xlabel('Time (s)')
ylabel('h_{DFA}')
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)

print -depsc2 -painters fract_dfa.eps
print -dpng fract_dfa.png


figure

subplot(2,1,1)
plot(2:2:2*length(fractalsMat(:,3)),fractalsMat(:,3),'Color',[202 0 32]./255,...
    'LineWidth',1)
hold on
plot(2:2:2*length(smoothdata(fractalsMat(:,3),'movmedian',50)),...
    smoothdata(fractalsMat(:,3),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
hold off
title('Variation of scaling exponent (with standardisation and sigmoid)')
xlim([2 3600])
ylim([1 1.8])
xlabel('Time (s)')
ylabel('FD_{Hig}')
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)

subplot(2,1,2)
plot(2:2:2*length(fractalsMat(:,4)),fractalsMat(:,4),'Color',[5 113 176]./255,...
    'LineWidth',1)
hold on
plot(2:2:2*length(smoothdata(fractalsMat(:,4),'movmedian',50)),...
    smoothdata(fractalsMat(:,4),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
hold off
title('Variation of scaling exponent')
xlim([2 3600])
ylim([1 1.8])
xlabel('Time (s)')
ylabel('FD_{Hig}')
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)

print -depsc2 -painters fract_hig.eps
print -dpng fract_hig.png


figure

subplot(3,1,1)
plot((2:2:2*length(stdPat)),stdPat(:,4),'Color',[146 197 222]./255, ...
    'LineWidth',3)
title('Modulating function')
xlim([0 3600])
ylim([1 5.5])
xlabel('Time (s)')

set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)

subplot(3,1,2)
plot((1:length(series))/512,series(:,4),'Color',[178 24 43]./255, ...
    'LineWidth',1)
title('Simulated time series')
xlim([0 3600])
ylim([-10 10])
xlabel('Time (s)')
ylabel('U(u.V)')

set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)

subplot(3,1,3)
plot((2:2:2*length(fractalsMat(:,5))),fractalsMat(:,5),'Color',[33 102 172]./255, ...
    'LineWidth',1)
hold on
plot(2:2:2*length(smoothdata(fractalsMat(:,5),'movmedian',50)),...
    smoothdata(fractalsMat(:,5),'movmedian',50),'Color',[0 0 0]./255,...
    'LineWidth',2)
hold off
title('Standard deviation')
xlim([0 3600])
ylim([0.4 4.3])
xlabel('Time (s)')

set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)

print -depsc2 -painters fract_modulation.eps
print -dpng fract_modulation.png
