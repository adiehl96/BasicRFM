% Just adds various folders to the path

me = mfilename;                                       % what is my filename
mydir = which(me); mydir = mydir(1:end-2-numel(me));  % where am I located

addpath(mydir(1:end-1));
addpath(genpath([mydir,'SliceSampling']));
addpath(genpath([mydir,'Utilities']));
addpath(genpath([mydir,'Enumerations']));
addpath(genpath([mydir,'Wrappers']));
addpath(genpath([mydir,'DataSets']));
addpath(genpath([mydir,'DataFolds']));
addpath(genpath([mydir,'Interface']));
addpath(genpath([mydir,'GewekeTestFunctions']));
% addpath(genpath([mydir,'TestingScripts']));
addpath(genpath([mydir,'SavedExperiments']));
addpath(genpath([mydir,'PartialResults']));
% addpath(genpath([mydir,'ForStack']));
addpath(genpath([mydir,'Analysis']));
addpath(genpath([mydir,'ExperimentAdmin']));
addpath(genpath([mydir,'IRM']));
addpath(genpath([mydir,'RandomIRM']));

clear me mydir;

gpml_startup;