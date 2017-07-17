function [deltaF,width] = chj_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io)

vec = size(data);
numSegments = vec(2)/segmentSize;
chNumber=vec(1);

%% INITIALISING VARIABLES

alphaMin = zeros(numSegments,chNumber+1);
alphaMin(:,1) = 1:numSegments;

alphaMax = zeros(numSegments,chNumber+1);
alphaMax(:,1) = 1:numSegments;

width = zeros(numSegments,chNumber+1);
width(:,1) = 1:numSegments;

deltaF = zeros(numSegments,chNumber+1);
deltaF(:,1) = 1:numSegments;


%% LOOP OVER THE CHANNELS OF THE EEG SIGNAL
for e = 1:chNumber
    
    %INITIALISING THE SPECTRUM VARIABLES VECTORS
    e
    
    alphaMinT = zeros(numSegments,1);
    alphaMaxT = zeros(numSegments,1);
    widthT = zeros(numSegments,1);
    fMin = zeros(numSegments,1);
    deltaFT = zeros(numSegments,1);
    
    
    electrode = data(e,:);
    electrode = reshape(electrode,segmentSize,[]);
    tam = size(electrode);
    
    
    
    %% LOOP OVER THE SEGMENTS OF THE CHANNEL RECORDING
    for col = 1:tam(2)
        
        electr = electrode(:,col);
        x = (electr - mean(electr))/std(electr);
        sigma = 1./(1 + exp(-x));
        
        
        % CHHABRA-JENSEN METHOD CALL
        [alpha,falpha,~,Rsqr_alpha,Rsqr_falpha,~,~,~,~,~]=...
            ChhabraJensen_Yuj_w0(sigma,qi:dq:qf,Io:Np);
        
        
        %% REMOVING BAD FITTING
        
        delW = (Rsqr_alpha >= Ra) & (Rsqr_falpha >= Ra);
        alpha = alpha(delW);
        falpha = falpha(delW);
        
        %% STORING THE OUTPUT OF THE MULTIFRACTAL ANALYSIS IN THE
        %% PROPER VARIABLES
        
        if isempty(alpha)
            
            alphaMinT(col,1) = NaN;
            alphaMaxT(col,1) = NaN;
            widthT(col,1) = NaN;
            
        else
            
            alphaMinT(col,1) = min(alpha);
            alphaMaxT(col,1) = max(alpha);
            widthT(col,1) = alphaMaxT(col,1) - alphaMinT(col,1);
            
        end
        
        if isempty(falpha)
            
            deltaFT(col,1) = NaN;
            
        else
            
            fMin(col,1) = min(falpha);
            deltaFT(col,1) = 1 - fMin(col,1);
            
        end
    end
    
    width(:,e+1) = widthT;
    deltaF(:,e+1) = deltaFT;
    
    
end

end