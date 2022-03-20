me = mfilename;                                       % what is my filename
mydir = which(me); mydir = mydir(1:end-2-numel(me));  % where am I located

addpath(mydir(1:end-1));
addpath([mydir,'GPML']);
addpath([mydir,'GPML/cov']);
addpath([mydir,'GPML/doc']);
addpath([mydir,'GPML/inf']);
addpath([mydir,'GPML/lik']);
addpath([mydir,'GPML/mean']);
addpath([mydir,'GPML/util']);
addpath([mydir,'GPML/jl_custom']);

clear me mydir;
