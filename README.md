# MultiFractalEEG

Figures of the artcle XXXXX

FIGURE 1 - .../sigmoid/  
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
FIGURE 5 - .../seizures_chTime/  
FIGURE 6 - .../relation_pBands/  
FIGURE 7 - .../relation_measures/  
FIGURE 8 - .../sleep/  
