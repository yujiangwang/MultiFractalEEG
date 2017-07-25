function [HigFD] = higuchi_nr_meth_n(data,segmentSize,Io)

vec = size(data);
numSegments = vec(2)/segmentSize;
chNumber=vec(1);

Kmax = segmentSize/Io;


%% LOOP OVER THE CHANNELS OF THE EEG SIGNAL
for e = 1:chNumber
    
    %INITIALISING THE SPECTRUM VARIABLES VECTORS
    e
    
    HigFD = zeros(numSegments,1);    
    
    electrode = data(e,:);
    electrode = reshape(electrode,segmentSize,[]);
    tam = size(electrode);
    
    disp([num2str(col/tam(2)*100) '%'])
    
    
    %% LOOP OVER THE SEGMENTS OF THE CHANNEL RECORDING
    for col = 1:tam(2)
        
        electr = electrode(:,col);
               
        
        % HIGUCHI METHOD CALL
        [HFD] = Higuchi_FD(electr, Kmax);
        disp([num2str(col/tam(2)*100) '%'])
        %% STORING THE OUTPUT OF THE MULTIFRACTAL ANALYSIS IN THE
        %% PROPER VARIABLES
       
        HigFD(col,1) = HFD;
       
    end
    
end

end