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