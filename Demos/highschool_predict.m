clear all;
cd ..
generic_startup;

params.SaveFilename = 'temp.mat'; % Location to save traces etc.
params.UU_Filename = 'HighSchool.csv';
params.U_Dim = 03; % Number of latent dimensions
params.UU_Folds = 05; % Number of folds for cross validation
params.UU_Fold = 01; % Fold to use
params.burn = 200;
params.iterations = 1000;
params.plot_modulus = 1000000; % How often to plot - i.e. never
params.UU_ObservationModel = ObservationModels.Logit;
params.n_pp_UU = 50; % Number of inducing points
params.Seed = 1; % Random seed

RFMExperiment(params);
