# MultiFractalEEG


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

## License

This work is licensed under the [MIT License](https://github.com/lucasfr/chhabra-jensen/blob/master/LICENSE). However, pieces of code used in this were licensed with different terms. They are listed bellow with.

Line colors - Matlab Copyright (c), [Jonathan C. Lansey](https://uk.mathworks.com/matlabcentral/fileexchange/42673-beautiful-and-distinguishable-line-colors-+-colormap)

WFDB Toolbox - GNU General Public License v3.0, [Ikaro Silva](https://github.com/ikarosilva/wfdb-app-toolbox/blob/master/LICENSE)

Higuchi and Katz fractal dimension measures - Copyright (c), [Jesús Monge](https://uk.mathworks.com/matlabcentral/fileexchange/50290-higuchi-and-katz-fractal-dimension-measures)

p-Model simulation - [Victor Venema](http://www2.meteo.uni-bonn.de/staff/venema/themes/surrogates/pmodel/)



Figures of the artcle XXXXX

FIGURE 1 - .../sigmoid/  
  
This figure was creared with a function to define the colours (included in this repository). The script was created by:  

Jonathan C. Lansey - lansey@gmail.com  
https://uk.mathworks.com/matlabcentral/fileexchange/42673-beautiful-and-distinguishable-line-colors-+-colormap?focused=5372538&tab=function  

FIGURE 2 - .../mapping_par/  
FIGURE 3 - .../fractal_methods/  

This figure was produced with 

link wfdb toolbox: https://github.com/ikarosilva/wfdb-app-toolbox  
link Higuchi script: https://uk.mathworks.com/matlabcentral/fileexchange/50290-higuchi-and-katz-fractal-dimension-measures  

The DFA function used in this article can be installed on MATLAB with the following commands.    

wfdb_url='https://github.com/ikarosilva/wfdb-app-toolbox/raw/master/wfdb-app-toolbox-0-9-10.zip';  
[filestr,status] = urlwrite(wfdb_url,'wfdb-app-toolbox-0-9-10.zip');  
unzip('wfdb-app-toolbox-0-9-10.zip');  
cd mcode  
addpath(pwd);  
savepath  

FIGURE 4 - .../mfractal_methods/

Victor Venema - Victor.Venema@uni-bonn.de  
http://www2.meteo.uni-bonn.de/staff/venema/themes/surrogates/pmodel/  

Espen A. F. Ihlen - espen.ihlen@ntnu.no  
http://journal.frontiersin.org/article/10.3389/fphys.2012.00141/full  

Gao-Feng Gu and Wei-Xing Zhou - wxzhou@ecust.edu.cn  
https://journals.aps.org/pre/abstract/10.1103/PhysRevE.82.011136  

FIGURE 5 - .../seizures_chTime/  
FIGURE 6 - .../relation_measures/  
FIGURE 7 - .../relation_pBands/  
FIGURE 8 - .../sleep/  
