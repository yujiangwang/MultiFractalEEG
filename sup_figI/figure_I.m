clear
close all
clc
addpath(genpath('../libs/'))

%% PARAMETERS

stdFactor = [0.01]; segSize = 1024;
qi=-15; qf=15; dq=1; Io=2; Np=8; Ra=0.9; sampRate = 512;

%% CREATING ARRAYS

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

%% CROPPING THE TIME SERIES

siz = floor(length(series)/segSize)*segSize;
data = series(1:siz);
data = data';

%% CHJ METHOD

[deltaF,width] = ...
    chj_nr_meth(data,segSize,qi,qf,dq,Np,Ra,Io);

%% PLOT

figure
plot(2:2:2*length(width(:,2)),width(:,2),'Color',[5 113 176]./255,...
    'LineWidth',1);
xlabel('Time (s)')
ylabel('\Delta\alpha')
xlim([2 2*length(width(:,2))])
set(gca,'FontSize',20,'FontName','Times')
set(gca,'LineWidth',1.5)

print -depsc2 -painters supFig_I.eps
print -dpng supFig_I.png