clear;
generic_startup;
fprintf('Startup at time %s\n', datestr(now,'HH:MM:SS.FFF'))

params.UU_Filename = 'SC_100307_den_30.csv';
params.U_Dim = 01; % Number of latent dimensions
params.UU_Folds = 01; % Number of folds for cross validation
% params.UU_Fold = 01; % Fold to use
params.burn = 200;
params.iterations = 2000;
params.plot_modulus = 10000000; % How often to plot - i.e. never
params.UU_ObservationModel = ObservationModels.Logit;
params.n_pp_UU = 30; % Number of inducing points
params.Seed = 1; % Random seed
params.pp_iterations = 10;
% params.init_method = InitialisationMethods.MAPU;
params.UU_Prior = KernelPriors.LogNormals;
 
RFMExperiment(params);

fprintf('Winddown at time %s\n', datestr(now,'HH:MM:SS.FFF'))
