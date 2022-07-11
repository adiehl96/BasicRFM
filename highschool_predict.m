clear;
generic_startup;
fprintf('Startup at time %s\n', datestr(now,'HH:MM:SS.FFF'))

% params.SaveFilename = 'temp.mat'; % Location to save traces etc.
params.UU_Filename = 'SC_100307_den_05.csv';
params.U_Dim = 01; % Number of latent dimensions
params.UU_Folds = 05; % Number of folds for cross validation
params.UU_Fold = 01; % Fold to use
params.burn = 1;
params.iterations = 1;
params.plot_modulus = 10000000; % How often to plot - i.e. never
params.UU_ObservationModel = ObservationModels.Logit;
params.n_pp_UU = 30; % Number of inducing points
params.Seed = 1; % Random seed
params.pp_iterations = 10;
% params.init_method = InitialisationMethods.MAPU;

RFMExperiment(params);

fprintf('Winddown at time %s\n', datestr(now,'HH:MM:SS.FFF'))
