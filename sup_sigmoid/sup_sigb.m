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

%Checked by YW 27th July 2017
clear
close all
addpath(genpath('~/GitHub/MultiFractalEEG/libs/'))

%% LOADING TIME SERIES

raw = load('series.txt');
raw = raw(:,2);

%% PARAMETERS

a = 1:1024;
b = a/512;

%% PLOTTING THE TIME SERIES

h = figure;

yyaxis right
plot(b,raw,'k','LineWidth',4)
ylim([min(raw) max(raw)])
ylabel('U(\muV)')

%% PLOTTING THE TRANSFORMED (standardised and sigmoid transformed) TIME SERIES FAMILY

C = linspecer(20);
yyaxis left
hold on
for k = 1:20

    [sigma] = sigmoidTrans(raw,0.1*k);
    plot(b,sigma,'color',C(k,:),'marker','none','linestyle','-','LineWidth',4)


end
hold off

left_color = [0 0 0];
right_color = [0 0 0];
set(h,'defaultAxesColorOrder',[left_color; right_color]);

xlim([min(b) max(b)])
ylabel({'U*'})
xlabel('Time (s)')
ylim([min(sigma) max(sigma)])
xlim([min(b) max(b)])

set(gca,'FontSize',18,'FontName','Times')

legend('v = 0.1','v = 0.2','v = 0.3','v = 0.4','v = 0.5','v = 0.6',...
    'v = 0.7','v = 0.8','v = 0.9','v = 1.0','v = 1.1','v = 1.2','v = 1.3',...
    'v = 1.4','v = 1.5','v = 1.6','v = 1.7','v = 1.8','v = 1.9','v = 2.0',...
    'Raw','location','bestoutside');

set(gca,'FontSize',18,'FontName','Times')
set(gca,'LineWidth',1.5)

print -depsc2 -painters sig_trans_comp.eps
print -dpng sig_trans_comp.png
