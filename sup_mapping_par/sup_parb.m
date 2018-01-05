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