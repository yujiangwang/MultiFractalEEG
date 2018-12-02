# Fractal and Multifractal Properties of Electrographic Recordings of Human Brain Activity: Towards its Use as a Signal Feature for Machine Learning in Clinical Applications

:warning: Please, use the following article for reference:

França, L.G.S., Miranda, J.G.V., Leite, M., Sharma, N.K., Walker, M.C., Lemieux, L. and Wang, Y., 2018. [Fractal and Multifractal Properties of Electrographic Recordings of Human Brain Activity: Towards its Use as a Signal Feature for Machine Learning in Clinical Applications](https://www.frontiersin.org/articles/10.3389/fphys.2018.01767/). Frontiers in Physiology, 9, p.1767. DOI: 10.3389/fphys.2018.01767

## Download

Please, clone the repository with the following command:

```
git clone https://github.com/yujiangwang/MultiFractalEEG
```

## R packages

Please, install the packages [ggplot2](https://github.com/tidyverse/ggplot2), [R.matlab](https://github.com/HenrikBengtsson/R.matlab), [reshape2](https://github.com/hadley/reshape), and [RColorBrewer](https://github.com/cran/RColorBrewer) with the following command on your R console:

```
install.packages("ggplot2", "R.matlab", "reshape2", "RColorBrewer")
```

## Matlab WFDB Toolbox

Please, copy and paste the following lines on your Matlab command window:

```
wfdb_url='https://github.com/ikarosilva/wfdb-app-toolbox/raw/master/wfdb-app-toolbox-0-9-10.zip';  
[filestr,status] = urlwrite(wfdb_url,'wfdb-app-toolbox-0-9-10.zip');  
unzip('wfdb-app-toolbox-0-9-10.zip');  
cd mcode  
addpath(pwd);  
savepath 
```

## License

This work is licensed under the [MIT License](https://github.com/lucasfr/chhabra-jensen/blob/master/LICENSE). 

Copyright (c) 2018 [Lucas G S França](https://lucasfr.github.io/), [Yujiang Wang](http://xaphire.de/), José G V Miranda. 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

However, pieces of code used in this were licensed with different terms. They are listed bellow with. 

Matlab line colors - Copyright (c), [Jonathan C. Lansey](https://uk.mathworks.com/matlabcentral/fileexchange/42673-beautiful-and-distinguishable-line-colors-+-colormap)<br />
WFDB Toolbox - GNU General Public License v3.0, [Ikaro Silva](https://github.com/ikarosilva/wfdb-app-toolbox/blob/master/LICENSE)<br />
Higuchi and Katz fractal dimension measures - Copyright (c), [Jesús Monge](https://uk.mathworks.com/matlabcentral/fileexchange/50290-higuchi-and-katz-fractal-dimension-measures)<br />
p-Model simulation - GNU public license, [Victor Venema](http://www2.meteo.uni-bonn.de/staff/venema/themes/surrogates/pmodel/)<br />
Multifractal Detrended Fluctuation Analysis - Copyright (c), [Espen A. F. Ihlen](https://www.ntnu.edu/inb/geri/software)<br />
Multifractal Detrended Moving Average - Copyright (c), [Gao-Feng Gu and Wei-Xing Zhou](https://journals.aps.org/pre/abstract/10.1103/PhysRevE.82.011136)<br />
gcmi : Gaussian-Copula Mutual Information - GNU General Public License v3.0, [Robin Ince](https://github.com/robince/gcmi)<br />


## Figures of the article XXXXX
  
FIGURE 2 - .../fractal_methods/  

:warning: Please, bear in mind that both Higuchi and DFA algorithms are not optimised and could take a while to run, depending on the performance of your machine.

FIGURE 3 - .../mfractal_methods/  
FIGURE 4 - .../szTrace/   
FIGURE 5 - .../relation_measures/  
FIGURE 6 - .../relation_pBands/  
FIGURE 7 - .../seizure_chTime/  
