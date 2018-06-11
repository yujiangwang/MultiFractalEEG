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

segmentSize = 1024;
qi=-15;
qf=15;
dq=1;
Io=2;
Np=8;

Ra=0.9;
sampRate = 100;
factor = segmentSize/sampRate;

load('ST7011J.mat');
ann = annExpndr(annot,onset,sData,sampRate);
[cz,oz] = sleepEval(ann,sData,segmentSize,sampRate,qi,qf,dq,Np,Ra,Io);
[classANOVA] = classDSamp(ann,cz.width(:,2),factor);
bMat = horzcat(classANOVA,cz.width(:,2),cz.deltaF(:,2),cz.deltaPR,...
    oz.width(:,2),oz.deltaF(:,2),oz.deltaPR);
[~,~,dStat] = mstdvar(sData(2,:),10.24,100);
dlmwrite(['sleep_ST7011J.csv'],bMat);

load('ST7022J.mat');
ann = annExpndr(annot,onset,sData,sampRate);
[cz,oz] = sleepEval(ann,sData,segmentSize,sampRate,qi,qf,dq,Np,Ra,Io);
[classANOVA] = classDSamp(ann,cz.width(:,2),factor);
bMat = horzcat(classANOVA,cz.width(:,2),cz.deltaF(:,2),cz.deltaPR,...
    oz.width(:,2),oz.deltaF(:,2),oz.deltaPR);
dlmwrite(['sleep_ST7022J.csv'],bMat);

load('ST7041J.mat');
ann = annExpndr(annot,onset,sData,sampRate);
[cz,oz] = sleepEval(ann,sData,segmentSize,sampRate,qi,qf,dq,Np,Ra,Io);
[classANOVA] = classDSamp(ann,cz.width(:,2),factor);
bMat = horzcat(classANOVA,cz.width(:,2),cz.deltaF(:,2),cz.deltaPR,...
    oz.width(:,2),oz.deltaF(:,2),oz.deltaPR);
dlmwrite(['sleep_ST7041J.csv'],bMat);

load('ST7052J.mat');
ann = annExpndr(annot,onset,sData,sampRate);
[cz,oz] = sleepEval(ann,sData,segmentSize,sampRate,qi,qf,dq,Np,Ra,Io);
[classANOVA] = classDSamp(ann,cz.width(:,2),factor);
bMat = horzcat(classANOVA,cz.width(:,2),cz.deltaF(:,2),cz.deltaPR,...
    oz.width(:,2),oz.deltaF(:,2),oz.deltaPR);
dlmwrite(['sleep_ST7052J.csv'],bMat);

load('ST7061J.mat');
ann = annExpndr(annot,onset,sData,sampRate);
[cz,oz] = sleepEval(ann,sData,segmentSize,sampRate,qi,qf,dq,Np,Ra,Io);
[classANOVA] = classDSamp(ann,cz.width(:,2),factor);
bMat = horzcat(classANOVA,cz.width(:,2),cz.deltaF(:,2),cz.deltaPR,...
    oz.width(:,2),oz.deltaF(:,2),oz.deltaPR);
dlmwrite(['sleep_ST7061J.csv'],bMat);