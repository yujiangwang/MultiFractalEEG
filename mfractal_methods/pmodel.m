function varargout = pmodel(noValues, p, slope)
% This function generates a multifractal time series using the p-model.
% Optionally you can also filter the result from the p-model in Fourier
% space to give it another fractal slope, e.g. to make it continuous and
% nonstationary. This is also called fractional integration. The p-model 
% itself can only produce stationary time series, i.e time series where 
% the variance is finite if you would extrapolate its power spectrum to 
% infinite large scales.
% 
% The parameter of the p-model is p. With p values close to 1 or 0 the time
% series is very peaked. With values close to 0.5 the p-model is much
% calmer; p=0.5 results in a constant unity vector.
% The parameter for the fractal integration is the slope of the power
% spectrum. Davis et al. calls slopes flatter than -1 stationary, and
% slopes between -1 and -3 nonstationary, with stationary increments. 
% These nonstationary cases are at least continuous, but not
% differentiable. Slopes steeper than -3 are nonstionary and
% differentiable.
% 
% Possible calls:
% [pModelTimeSeries] = pmodel
% [pModelTimeSeries] = pmodel(noValues)
% [pModelTimeSeries] = pmodel(noValues, p)
% [fractionalIntegratedTimeSeries] = pmodel(noValues, p, slope)
% [fractionalIntegratedTimeSeries, pModelTimeSeries] = pmodel(noValues, p, slope)
% If no number of values (noValues) is specified or it is empty, the
% default value of 256 is used.
% If no p is specified or it is empty, the default value of 0.375 is used.
% If no slope is specified, you will get a time series without fractional
% integration.
% If a slope is specified you will get the fractionally integrated time
% series, or if you use two output variables you will get both the p-model
% time series as well as its fractionally integrated version.

% This Matlab function is based on the article: Davis, A., A. Marshak, R.
% Cahalan, and W. Wiscombe, The landsat scale break in stratocumulus as a
% three-dimensional radiative transfer effect: implications for cloud
% remote sensing. Journal of the Atmospheric Sciences, Vol. 54, no. 2,
% 1997.
% First version by Victor Venema, Victor.Venema@uni-bonn.de, 25 January
% 2006.

% Check input
if ( nargin < 1 | isempty(noValues) )
    noValues = 256;
end
if ( nargin < 2 | isempty(p) )
    p = 0.375;
end
if ( nargin < 3 )
    slope = [];
end

% Calculate length of time series
noOrders = ceil(log2(noValues));
noValuesGenerated = 2.^(noOrders);

% y is the time series generated with the p-model.
y = 1;
for n=1:noOrders
    y = next_step_1d(y, p);
end

% If a slope if specified also a fractionally integrated time series (x) is
% calculated from y.
if ( ~isempty(slope) )
    fourierCoeff = fractal_spectrum_1d(noValues, slope/2)'; % Calculate the magnitudes of the coefficients of the Fourier spectrum. The Fourier slope is half of the slope of the power spectrum.
    meanVal = mean(y);
    stdy = std(y);
    x = ifft(y-meanVal);              % Calculate the Fourier coefficients of the original p-model time series
    phase = angle(x);                 % Calculate the phases, as these are kept intact, should not be changed by the Fourier filter.
    x = fourierCoeff .* exp(i*phase); % Calculate the complex Fourier coefficients with the specified spectral slope, and the phases of the p-model.
    x = real(fft(x));                 % Generate the fractionally integrated time series.
    x = x * stdy / std(x);
    x = x + meanVal;
else
    x = y;
end

% Reduce the sizes of the time series and put them in the right output
% variable.
if (nargout == 1 )
    y=y(1:noValues);
    varargout{1} = x;
else
    y=y(1:noValues);
    x=x(1:noValues);
    varargout{1} = x;
    varargout{2} = y;
end


function y2 = next_step_1d(y, p)

len = numel(y);

y2 = zeros(1,len*2);
sign = rand(1, len)-0.5;
sign = sign./abs(sign);

y2(1:2:2*len-1) = y + sign.*(1-2*p).*y;
y2(2:2:2*len)   = y - sign.*(1-2*p).*y;


function a = fractal_spectrum_1d(noValues, slope)
% If you want to make a large number of time series, please rewrite this
% part to get rid of the for-loop. :-)

ori_vector_size = noValues;
ori_half_size   = ori_vector_size/2;
a = zeros(ori_vector_size,1); % The magnitudes of the Fourier coefficients

for t2 = 1:ori_half_size+1
    index = t2-1;
    t4 = 2 + ori_vector_size - t2;
    if ( t4 > ori_vector_size ) 
        t4 = t2;
    end    
    coeff = index.^slope;
    a(t2) = coeff;
    a(t4) = coeff;
end

a(1) = 0; % the DC-component of the Fourier spectrum should be zero.