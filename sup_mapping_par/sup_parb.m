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

load('JR_12062011_1630_1730.mat');

rng('default');
rng(666);
rand = randn(1,length(szClip(1,:)));

rng('default');
rng(666);
ix = randperm(length(szClip(1,:)));
surrEEG(1,:) = szClip(ix);


vVect = 0.1:0.1:2;
corMat = zeros(length(vVect),2);
corMat(:,1) = vVect;

ts = szClip(1,:);
tsS = surrEEG;
tsR = rand;

for i = 1:length(vVect)
    
    x = ((ts - mean(ts))/std(ts));
    sigma = 1./(1 + exp(-vVect(i)*x));
    
    rho = corr(ts',sigma');
    corMat(i,2) = rho;
    
    x = ((tsS - mean(tsS))/std(tsS));
    sigma = 1./(1 + exp(-vVect(i)*x));
    
    rho = corr(tsS',sigma');
    corMat(i,3) = rho;
    
    x = ((tsR - mean(tsR))/std(tsR));
    sigma = 1./(1 + exp(-vVect(i)*x));
    
    rho = corr(tsR',sigma');
    corMat(i,4) = rho;
    
end


plot(corMat(:,1),corMat(:,2),'-o','Color',[202 0 32]./255,'LineWidth',3)
hold on
plot(corMat(:,1),corMat(:,3),'-o','Color',[146 197 222]./255,'LineWidth',3)
plot(corMat(:,1),corMat(:,4),'-o','Color',[5 113 176]./255,'LineWidth',3)
box on

set(gca,...
'FontSize',18,...
'FontName','Times')

xlabel('v','FontSize',18)
ylabel('\rho','FontSize',18)
legend('Signal','Surrogate','Random','location','Best')

set(gca,'LineWidth',1.5)

print -depsc2 -painters sigmaCor.eps
print -dpng sigmaCor.png