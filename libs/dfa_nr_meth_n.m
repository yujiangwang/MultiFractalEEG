function [dfaFD] = dfa_nr_meth_n(data,segmentSize,Np,Io)

vec = size(data);
numSegments = vec(2)/segmentSize;
chNumber=vec(1);

minWin = 2^Io;
maxWin = 2^Np;

%% LOOP OVER THE CHANNELS OF THE EEG SIGNAL
for e = 1:chNumber
    
    %INITIALISING THE SPECTRUM VARIABLES VECTORS
    
    dfaFD = zeros(numSegments,1);    
    
    electrode = data(e,:);
    electrode = reshape(electrode,segmentSize,[]);
    tam = size(electrode);
    
    
    
    %% LOOP OVER THE SEGMENTS OF THE CHANNEL RECORDING
    for col = 1:tam(2)
        
        electr = electrode(:,col);        
        
        % DFA METHOD CALL
        [ln,lf] = dfa(electr,1,false,minWin,maxWin,false);
        %% STORING THE OUTPUT OF THE MULTIFRACTAL ANALYSIS IN THE
        %% PROPER VARIABLES
        
        mdl = fitlm(ln,lf);
        b = mdl.Coefficients.Estimate(2);
        dfaFD(col,1) = b;
       
    end
    
end

end