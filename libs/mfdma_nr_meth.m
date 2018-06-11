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

function [deltaF,width] = mfdma_nr_meth(data,segmentSize,qi,qf,dq,Np,Ra,Io)

%this is the MFDMA method that include a standardisation & sigmoid
%transform of the data.

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
