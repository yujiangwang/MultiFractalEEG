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

function [deltaPR] = deltaBand(series,sampRate,wSize)

% RETURNS THE DELTA BAND POWER


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FILTERS LOT

%% 0.5-4

[b,a] = butter(4, 4/(sampRate/2), 'low');
delta = filter(b,a,series);
[b,a] = butter(4, 0.5/(sampRate/2), 'high');
delta = filter(b,a,delta);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% RESHAPE PROC.

delta = reshape(delta,wSize,[]);
raw = reshape(series,wSize,[]);
%% POWER OPS.

deltaP = zeros(length(delta),1);
rawP = zeros(length(raw),1);

for i=1:length(delta)

    deltaP(i,1) = sumsqr(delta(:,i));
    rawP(i,1) = sumsqr(raw(:,i));

end

% RELATIVE POWER

deltaPR = deltaP./rawP;

end
