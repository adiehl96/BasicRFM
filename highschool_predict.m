generic_startup;

params.SaveFilename = 'temp.mat'; % Location to save traces etc.
params.UU_Filename = 'SC_100307_den_1.csv';
params.U_Dim = 01; % Number of latent dimensions
params.UU_Folds = 05; % Number of folds for cross validation
params.UU_Fold = 01; % Fold to use
params.burn = 200;
params.iterations = 10000;
params.plot_modulus = 1000000; % How often to plot - i.e. never
params.UU_ObservationModel = ObservationModels.Logit;
params.n_pp_UU = 50; % Number of inducing points
params.Seed = 1; % Random seed
params.pp_iterations = 1;

RFMExperiment(params);
