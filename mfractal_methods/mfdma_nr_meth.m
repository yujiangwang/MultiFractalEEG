function [deltaF,width] = mfdma_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io)

vec = size(data);
numSegments = vec(2)/segmentSize;
chNumber=vec(1);

%% INITIALISING VARIABLES

alphaMin = zeros(numSegments,chNumber+1);
alphaMin(:,1) = 1:numSegments;

alphaMax = zeros(numSegments,chNumber+1);
alphaMax(:,1) = 1:numSegments;

widthMFDMA = zeros(numSegments,chNumber+1);
widthMFDMA(:,1) = 1:numSegments;

deltaFMFDMA = zeros(numSegments,chNumber+1);
deltaFMFDMA(:,1) = 1:numSegments;


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
        [~,~,~,alpha,falpha] = MFDMA_1D(sigma,2^Io,2^Np,31,0,qi:dq:qf);
        col
               
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