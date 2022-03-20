clear all;
cd ..
generic_startup;

params.SaveFilename = 'temp.mat';
params.UU_Filename = '2Clique100.csv';
params.U_Dim = 01;
params.UU_Folds = 01;
params.burn = 0;
params.iterations = 100;
params.plot_modulus = 1;
params.UU_ObservationModel = ObservationModels.Logit;
params.n_pp_UU = 30;

RFMExperiment(params);
