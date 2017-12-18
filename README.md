# Fractal and multifractal properties of electrographic recordings of human brain activity


## Download

Please, clone the repository with the following command:

```
git clone https://github.com/yujiangwang/MultiFractalEEG
```

## R packages

Please, install the packages ggplot2, R.matlab, reshape2, PerformanceAnalytics, and RColorBrewer with the following command on your R console:

```
install.packages("ggplot2, R.matlab, reshape2, PerformanceAnalytics, RColorBrewer")
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

This work is licensed under the [MIT License](https://github.com/lucasfr/chhabra-jensen/blob/master/LICENSE). However, pieces of code used in this were licensed with different terms. They are listed bellow with.<br />

Line colors - Matlab Copyright (c), [Jonathan C. Lansey](https://uk.mathworks.com/matlabcentral/fileexchange/42673-beautiful-and-distinguishable-line-colors-+-colormap)<br />
WFDB Toolbox - GNU General Public License v3.0, [Ikaro Silva](https://github.com/ikarosilva/wfdb-app-toolbox/blob/master/LICENSE)<br />
Higuchi and Katz fractal dimension measures - Copyright (c), [Jesús Monge](https://uk.mathworks.com/matlabcentral/fileexchange/50290-higuchi-and-katz-fractal-dimension-measures)<br />
p-Model simulation - GNU public license, [Victor Venema](http://www2.meteo.uni-bonn.de/staff/venema/themes/surrogates/pmodel/)<br />
Multifractal Detrended Fluctuation Analysis - Copyright (c), [Espen A. F. Ihlen](https://www.ntnu.edu/inb/geri/software)<br />
Multifractal Detrended Moving Average - Copyright (c), [Gao-Feng Gu and Wei-Xing Zhou](https://journals.aps.org/pre/abstract/10.1103/PhysRevE.82.011136)<br />


## Figures of the artcle XXXXX

FIGURE 1 - .../sigmoid/  
FIGURE 2 - .../mapping_par/  
FIGURE 3 - .../fractal_methods/  

:warning: Please, bear in mind that both Higuchi and DFA algorithms are not optimised and could take a while to run depending on the performance of your machine.

FIGURE 4 - .../mfractal_methods/
FIGURE 5 - .../seizures_chTime/  
FIGURE 6 - .../relation_measures/  
FIGURE 7 - .../relation_pBands/  
FIGURE 8 - .../sleep/  
