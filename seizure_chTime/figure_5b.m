clear
close all

id = 'I001_P005_D01';

szPoint = 25220; szPointF = 25290.5; nullPoint = szPoint - 1800;
nullPointF = szPointF - 1800; sampRate = 5000;


%% iEEG.ORG SESSION (PLEASE REPLACE xxx WITH YOUR DETAILS)

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
% save('figure_5b.mat','values','valuesSz')

load('figure_5b.mat')


for chNum = [1:3, 29:31]
    
    szRaw{1} = valuesSz(:,chNum);
    szRawi{1} = resample(valuesSz(:,chNum),6,5);
    szRawi2{1} = resample(valuesSz(:,chNum),4,5);
    
    nullRaw{1} = values(:,chNum);
    nullRawi{1} = resample(values(:,chNum),6,5);
    nullRawi2{1} = resample(values(:,chNum),4,5);
    
    szNum = 1:length(szRaw);
    
    
    wSizes = [1024, 2048, 4096, 8192];
    sampRates = [5000, 2500, 1000, 500, 250];
    
    filename = ['effSize_' id '_ch_' num2str(chNum)];
    swSpotEval(szRaw,nullRaw,filename,wSizes,szNum,...
        5000,sampRates,-15,15,1,2,8,0.9);
    
    
    wSizes = [1024, 2048, 4096, 8192];
    sampRates = [3000,2000,1500,1200,750,600,300];
    
    filename = ['effSize_i' id '_ch_' num2str(chNum)];
    swSpotEval(szRawi,nullRawi,filename,wSizes,szNum,...
        6000,sampRates,-15,15,1,2,8,0.9);
    
    wSizes = [1024, 2048, 4096, 8192];
    sampRates = [4000,800,400];
    
    filename = ['effSize_i2' id '_ch_' num2str(chNum)];
    swSpotEval(szRawi2,nullRawi2,filename,wSizes,szNum,...
        4000,sampRates,-15,15,1,2,8,0.9);
    
end
