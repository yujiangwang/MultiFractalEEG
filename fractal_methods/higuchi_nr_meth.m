function [HigFD] = higuchi_nr_meth(data,segmentSize,Io)

vec = size(data);
numSegments = vec(2)/segmentSize;
chNumber=vec(1);

Kmax = segmentSize/Io;


%% LOOP OVER THE CHANNELS OF THE EEG SIGNAL
for e = 1:chNumber
    
    %INITIALISING THE SPECTRUM VARIABLES VECTORS
    
    HigFD = zeros(numSegments,1);    
    
    electrode = data(e,:);
    electrode = reshape(electrode,segmentSize,[]);
    tam = size(electrode);
    
    
    
    %% LOOP OVER THE SEGMENTS OF THE CHANNEL RECORDING
    for col = 1:tam(2)
        
        electr = electrode(:,col);
        x = (electr - mean(electr))/std(electr);
        sigma = 1./(1 + exp(-x));
        
        
        % CHHABRA-JENSEN METHOD CALL
        [HFD] = Higuchi_FD(sigma, Kmax);
        col
        %% STORING THE OUTPUT OF THE MULTIFRACTAL ANALYSIS IN THE
        %% PROPER VARIABLES
       
        HigFD(col,1) = HFD;
       
    end
    
end

end