function [ RFM, MCMC ] = SetupObjects( params )
%SETUPOBJECTS Create RFM and MCMC objects
% This will deal with all the fiddly code of loading data etc
%
% James Lloyd, July 2012

  %%%% TODO - add row fold to everything

  %%%% Extract parameters or load defaults
  
  if (nargin < 1) || (isempty(params))
    % Only defaults - for testing only
    params.UU_Filename = '2Clique20.csv';
  end

  % Randomness
  
  Seed = value_or_default(params, 'Seed', 1);

  % Start printing the program parameter values to file.
  fid = fopen('output/program_params.txt', 'wt');
  fprintf(fid, 'Seed, %d\n', Seed);
  fclose(fid);
  fid = fopen('output/program_params.txt', 'a+');
  
  % Dimensions of model
  
  U_Dim = value_or_default(params, 'U_Dim', 1);
  fprintf(fid, 'U_Dim, %d\n', U_Dim);
  
  % UU array
  
  UU_Filename = value_or_default(params, 'UU_Filename', '');
  fprintf(fid, 'UU_Filename, %s\n', UU_Filename);
  UU_square = value_or_default(params, 'UU_square', true);
  fprintf(fid, 'UU_square, %s\n', string(UU_square));
  UU_undirected = value_or_default(params, 'UU_undirected', true);
  fprintf(fid, 'UU_undirected, %s\n', string(UU_undirected));
  UU_Folds = value_or_default(params, 'UU_Folds', 5);
  fprintf(fid, 'UU_Folds, %s\n', string(UU_Folds));
  UU_Fold = value_or_default(params, 'UU_Fold', 1);
  fprintf(fid, 'UU_Fold, %s\n', string(UU_Fold));
  
  UU_KernelName = value_or_default(params, 'UU_KernelName', 'covSEard_sym');
  fprintf(fid, 'UU_KernelName, %s\n', string(UU_KernelName));
  UU_DiagNoise = value_or_default(params, 'UU_DiagNoise', log(0.1));
  fprintf(fid, 'UU_DiagNoise, %s\n', string(UU_DiagNoise));

  if strcmp (UU_KernelName, 'covSEiso_sym') || strcmp (UU_KernelName, 'covSEiso')
    dims = 1;
  elseif strcmp (UU_KernelName, 'covSEard_sym')
    dims = U_Dim;
  else
    dims = 2 * U_Dim;
  end
  UU_KernelParams = value_or_default(params, 'UU_KernelParams', [log(1) * ones(dims, 1); log(2)]);
  fprintf(fid, 'UU_KernelParams, %s\n', string(UU_KernelParams));
  UU_Prior = value_or_default(params, 'UU_Prior', KernelPriors.InverseGammas);
  fprintf(fid, 'UU_Prior, %s\n', string(UU_Prior));

  switch UU_Prior
    case KernelPriors.LogNormals
      ParamDefaults = [UU_KernelParams, 0.5 * ones(length(UU_KernelParams), 1)];
      UU_NoiseParams = [log(0.1), 0.5];
    case KernelPriors.InverseGammas
      ParamDefaults = 0.1 * ones(length(UU_KernelParams), 2);
      UU_NoiseParams = 0.1 * ones(1, 2);
  end
  UU_KernPriorParams = value_or_default(params, 'UU_KernelParams', ParamDefaults);
  fprintf(fid, 'UU_KernelParams, %s\n', string(UU_KernelParams));
  
  UU_ObservationModel = value_or_default(params, 'UU_ObservationModel', ObservationModels.Logit);
  fprintf(fid, 'UU_ObservationModel, %s\n', string(UU_ObservationModel));
  UU_DataPrecision = value_or_default(params, 'UU_DataPrecision', 1);
  fprintf(fid, 'UU_DataPrecision, %s\n', string(UU_DataPrecision));
  n_pp_UU = value_or_default(params, 'n_pp_UU', 50);
  fprintf(fid, 'n_pp_UU, %s\n', string(n_pp_UU));
  
  % MCMC
  
  LV_modulus = value_or_default(params, 'LV_modulus', 1);
  fprintf(fid, 'LV_modulus, %s\n', string(LV_modulus));
  pp_modulus = value_or_default(params, 'pp_modulus', 1);
  fprintf(fid, 'pp_modulus, %s\n', string(pp_modulus));
  kern_par_modulus = value_or_default(params, 'kern_par_modulus', 1);
  fprintf(fid, 'kern_par_modulus, %s\n', string(kern_par_modulus));
  data_par_modulus = value_or_default(params, 'data_par_modulus', 1);
  fprintf(fid, 'data_par_modulus, %s\n', string(data_par_modulus));
  T_modulus = value_or_default(params, 'T_modulus', 1);
  fprintf(fid, 'T_modulus, %s\n', string(T_modulus));
  T_iterations = value_or_default(params, 'T_iterations', 50);
  fprintf(fid, 'T_iterations, %s\n', string(T_iterations));
  pp_iterations = value_or_default(params, 'pp_iterations', 10);
  fprintf(fid, 'pp_iterations, %s\n', string(pp_iterations));
  burn = value_or_default(params, 'burn', 5);
  fprintf(fid, 'burn, %s\n', string(burn));
  iterations = value_or_default(params, 'iterations', 20);
  fprintf(fid, 'iterations, %s\n', string(iterations));
  plot_modulus = value_or_default(params, 'plot_modulus', 1);
  fprintf(fid, 'plot_modulus, %s\n', string(plot_modulus));
  talk_modulus = value_or_default(params, 'talk_modulus', 1);
  fprintf(fid, 'talk_modulus, %s\n', string(talk_modulus));
  
  surf_sample = value_or_default(params, 'surf_sample', true);
  fprintf(fid, 'surf_sample, %s\n', string(surf_sample));
  
  UU_kern_par_widths = value_or_default(params, 'UU_kern_par_widths', ...
                                        [0.5 * ones(length(UU_KernelParams), 1); 0.1]);
                                      
  fprintf(fid, 'UU_kern_par_widths, %s\n', string(UU_kern_par_widths));
  init_method = value_or_default(params, 'init_method', InitialisationMethods.None);
  fprintf(fid, 'init_method, %s\n', string(init_method));
  fclose(fid);
  %%%% Setup
  
  % Load path and create objects
  
  generic_startup;
  RFM = hcRFM;
  MCMC = hcMCMC_SS_RFM;
  MCMC.RFM = RFM;
  MCMC.UU_Filename = UU_Filename;
  RFM.D_L_U = U_Dim;

  % Load UU array
  
  UU_Data = hc2ArrayData;
  UU_Data.LoadFromFile (UU_Filename, UU_square, UU_undirected);
  Data = UU_Data.Partition (UU_Folds, UU_Fold, Seed);
  delete (UU_Data);
  RFM.data_UU = Data;
  disp(size(RFM.data_UU.test_X_v{1}))
  
  UU_Group_Filename = value_or_default(params, 'UU_Group_Filename', '');
  UU_Group = hc2ArrayData;
  UU_Group.LoadFromFile (UU_Group_Filename, UU_square, UU_undirected);
  RFM.group_UU = UU_Group;
  
  RFM.ObservationModel_UU = UU_ObservationModel;
  RFM.DataPrecision_UU = UU_DataPrecision;
  
  % Setup UU kernel
  
  RFM.arrayKern_UU.name = UU_KernelName;
  RFM.arrayKern_UU.diagNoise = UU_DiagNoise;
  RFM.arrayKern_UU.params = UU_KernelParams;
  RFM.arrayKern_UU.priorParams = UU_KernPriorParams;
  RFM.arrayKern_UU.noiseParams = UU_NoiseParams;
  RFM.arrayKern_UU.priorType = UU_Prior;
  
  RFM.n_pp_UU = n_pp_UU;
  
  
  % Set MCMC parameters
  
  MCMC.burn = burn;
  MCMC.iterations = iterations;
  
  MCMC.LV_modulus = LV_modulus;
  MCMC.pp_modulus = pp_modulus;
  MCMC.pp_iterations = pp_iterations;
  MCMC.kern_par_modulus = kern_par_modulus;
  MCMC.data_par_modulus = data_par_modulus;
  MCMC.T_modulus = T_modulus;
  MCMC.T_iterations = T_iterations;
  MCMC.plot_modulus = plot_modulus;
  MCMC.talk_modulus = talk_modulus;
  
  MCMC.surf_sample = surf_sample;
  
  MCMC.kern_par_widths.UU = UU_kern_par_widths;
  
  MCMC.init_method = init_method;

end

