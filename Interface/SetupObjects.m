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
  
  % Dimensions of model
  
  U_Dim = value_or_default(params, 'U_Dim', 1);
  V_Dim = value_or_default(params, 'V_Dim', 1);
  
  % UU array
  
  UU_Filename = value_or_default(params, 'UU_Filename', '');
  UU_square = value_or_default(params, 'UU_square', true);
  UU_undirected = value_or_default(params, 'UU_undirected', true);
  UU_Folds = value_or_default(params, 'UU_Folds', 5);
  UU_Fold = value_or_default(params, 'UU_Fold', 1);
  UU_FoldFlip = value_or_default(params, 'UU_FoldFlip', false);
  
  UU_KernelName = value_or_default(params, 'UU_KernelName', 'covSEard_sym');
  UU_DiagNoise = value_or_default(params, 'UU_DiagNoise', log(0.1));
  if strcmp (UU_KernelName, 'covSEiso_sym') || strcmp (UU_KernelName, 'covSEiso')
    dims = 1;
  elseif strcmp (UU_KernelName, 'covSEard_sym')
    dims = U_Dim;
  else
    dims = 2 * U_Dim;
  end
  UU_KernelParams = value_or_default(params, 'UU_KernelParams', [log(1) * ones(dims, 1); log(2)]);
  UU_Prior = value_or_default(params, 'UU_Prior', KernelPriors.InverseGammas);
  
  switch UU_Prior
    case KernelPriors.LogNormals
      ParamDefaults = [UU_KernelParams, 0.5 * ones(length(UU_KernelParams), 1)];
      UU_NoiseParams = [log(0.1), 0.5];
    case KernelPriors.InverseGammas
      ParamDefaults = 0.1 * ones(length(UU_KernelParams), 2);
      UU_NoiseParams = 0.1 * ones(1, 2);
  end
  UU_KernPriorParams = value_or_default(params, 'UU_KernelParams', ParamDefaults);
  
  UU_ObservationModel = value_or_default(params, 'UU_ObservationModel', ObservationModels.Logit);
  UU_DataPrecision = value_or_default(params, 'UU_DataPrecision', 1);
  n_pp_UU = value_or_default(params, 'n_pp_UU', 50);
  
  % VV array
  
  VV_Filename = value_or_default(params, 'VV_Filename', '');
  VV_square = value_or_default(params, 'VV_square', true);
  VV_undirected = value_or_default(params, 'VV_undirected', true);
  VV_Folds = value_or_default(params, 'VV_Folds', 5);
  VV_Fold = value_or_default(params, 'VV_Fold', 1);
  VV_FoldFlip = value_or_default(params, 'VV_FoldFlip', false);
  
  VV_KernelName = value_or_default(params, 'VV_KernelName', 'covSEard_sym');
  VV_DiagNoise = value_or_default(params, 'VV_DiagNoise', log(0.1));
  if strcmp (VV_KernelName, 'covSEiso_sym') || strcmp (VV_KernelName, 'covSEiso')
    dims = 1;
  elseif strcmp (VV_KernelName, 'covSEard_sym')
    dims = V_Dim;
  else
    dims = 2 * V_Dim;
  end
  VV_KernelParams = value_or_default(params, 'VV_KernelParams', [log(1) * ones(dims, 1); log(2)]);
  VV_Prior = value_or_default(params, 'VV_Prior', KernelPriors.InverseGammas);
  
  switch VV_Prior
    case KernelPriors.LogNormals
      ParamDefaults = [VV_KernelParams, 0.5 * ones(length(VV_KernelParams), 1)];
      VV_NoiseParams = [log(0.1), 0.5];
    case KernelPriors.InverseGammas
      ParamDefaults = 0.1 * ones(length(VV_KernelParams), 2);
      VV_NoiseParams = 0.1 * ones(1, 2);
  end
  VV_KernPriorParams = value_or_default(params, 'VV_KernelParams', ParamDefaults);
  
  VV_ObservationModel = value_or_default(params, 'VV_ObservationModel', ObservationModels.Logit);
  VV_DataPrecision = value_or_default(params, 'VV_DataPrecision', 1);
  n_pp_VV = value_or_default(params, 'n_pp_VV', 50);
  
  % UV array
  
  UV_Filename = value_or_default(params, 'UV_Filename', '');
  UV_square = value_or_default(params, 'UV_square', true);
  UV_undirected = value_or_default(params, 'UV_undirected', true);
  UV_Folds = value_or_default(params, 'UV_Folds', 5);
  UV_Fold = value_or_default(params, 'UV_Fold', 1);
  UV_FoldFlip = value_or_default(params, 'UV_FoldFlip', false);
  UV_FoldRow = value_or_default(params, 'UV_FoldRow', false);
  
  UV_KernelName = value_or_default(params, 'UV_KernelName', 'covSEard');
  UV_DiagNoise = value_or_default(params, 'UV_DiagNoise', log(0.1));
  if strcmp (UV_KernelName, 'covSEiso_sym') || strcmp (UV_KernelName, 'covSEiso')
    dims = 1;
  else
    dims = U_Dim + V_Dim;
  end
  UV_KernelParams = value_or_default(params, 'UV_KernelParams', [log(1) * ones(dims, 1); log(2)]);
  UV_Prior = value_or_default(params, 'UV_Prior', KernelPriors.InverseGammas);
  
  switch UV_Prior
    case KernelPriors.LogNormals
      ParamDefaults = [UV_KernelParams, 0.5 * ones(length(UV_KernelParams), 1)];
      UV_NoiseParams = [log(0.1), 0.5];
    case KernelPriors.InverseGammas
      ParamDefaults = 0.1 * ones(length(UV_KernelParams), 2);
      UV_NoiseParams = 0.1 * ones(1, 2);
  end
  UV_KernPriorParams = value_or_default(params, 'UV_KernelParams', ParamDefaults);
  
  UV_ObservationModel = value_or_default(params, 'UV_ObservationModel', ObservationModels.Logit);
  UV_DataPrecision = value_or_default(params, 'UV_DataPrecision', 1);
  n_pp_UV = value_or_default(params, 'n_pp_UV', 50);
  
  % UCov data
  
  UCov_Filename = value_or_default(params, 'UCov_Filename', '');
  UCov_square = value_or_default(params, 'UCov_square', true);
  UCov_undirected = value_or_default(params, 'UCov_undirected', true);
  UCov_Folds = value_or_default(params, 'UCov_Folds', 5);
  UCov_Fold = value_or_default(params, 'UCov_Fold', 1);
  UCov_FoldFlip = value_or_default(params, 'UCov_FoldFlip', false);
  
  UCov_KernelName = value_or_default(params, 'UCov_KernelName', 'covSEard');
  UCov_DiagNoise = value_or_default(params, 'UCov_DiagNoise', log(0.1));
  if strcmp (UCov_KernelName, 'covSEiso_sym') || strcmp (UCov_KernelName, 'covSEiso')
    dims = 1;
  else
    dims = U_Dim;
  end
  UCov_KernelParams = value_or_default(params, 'UCov_KernelParams', [log(1) * ones(dims, 1); log(2)]);
  UCov_Prior = value_or_default(params, 'UCov_Prior', KernelPriors.InverseGammas);
  
  switch UCov_Prior
    case KernelPriors.LogNormals
      ParamDefaults = [UCov_KernelParams, 0.5 * ones(length(UCov_KernelParams), 1)];
      UCov_NoiseParams = [log(0.1), 0.5];
    case KernelPriors.InverseGammas
      ParamDefaults = 0.1 * ones(length(UCov_KernelParams), 2);
      UCov_NoiseParams = 0.1 * ones(1, 2);
  end
  UCov_KernPriorParams = value_or_default(params, 'UCov_KernelParams', ParamDefaults);
  
  UCov_ObservationModel = value_or_default(params, 'UCov_ObservationModel', ObservationModels.Logit);
  UCov_DataPrecision = value_or_default(params, 'UCov_DataPrecision', 1);
  n_pp_UCov = value_or_default(params, 'n_pp_UCov', 50);
  
  % VCov data
  
  VCov_Filename = value_or_default(params, 'VCov_Filename', '');
  VCov_square = value_or_default(params, 'VCov_square', true);
  VCov_undirected = value_or_default(params, 'VCov_undirected', true);
  VCov_Folds = value_or_default(params, 'VCov_Folds', 5);
  VCov_Fold = value_or_default(params, 'VCov_Fold', 1);
  VCov_FoldFlip = value_or_default(params, 'VCov_FoldFlip', false);
  
  VCov_KernelName = value_or_default(params, 'VCov_KernelName', 'covSEard');
  VCov_DiagNoise = value_or_default(params, 'VCov_DiagNoise', log(0.1));
  if strcmp (VCov_KernelName, 'covSEiso_sym') || strcmp (VCov_KernelName, 'covSEiso')
    dims = 1;
  else
    dims = V_Dim;
  end
  VCov_KernelParams = value_or_default(params, 'VCov_KernelParams', [log(1) * ones(dims, 1); log(2)]);
  VCov_Prior = value_or_default(params, 'VCov_Prior', KernelPriors.InverseGammas);
  
  switch VCov_Prior
    case KernelPriors.LogNormals
      ParamDefaults = [VCov_KernelParams, 0.5 * ones(length(VCov_KernelParams), 1)];
      VCov_NoiseParams = [log(0.1), 0.5];
    case KernelPriors.InverseGammas
      ParamDefaults = 0.1 * ones(length(VCov_KernelParams), 2);
      VCov_NoiseParams = 0.1 * ones(1, 2);
  end
  VCov_KernPriorParams = value_or_default(params, 'VCov_KernelParams', ParamDefaults);
  
  VCov_ObservationModel = value_or_default(params, 'VCov_ObservationModel', ObservationModels.Logit);
  VCov_DataPrecision = value_or_default(params, 'VCov_DataPrecision', 1);
  n_pp_VCov = value_or_default(params, 'n_pp_VCov', 50);
  
  % MCMC
  
  LV_modulus = value_or_default(params, 'LV_modulus', 1);
  pp_modulus = value_or_default(params, 'pp_modulus', 1);
  kern_par_modulus = value_or_default(params, 'kern_par_modulus', 1);
  data_par_modulus = value_or_default(params, 'data_par_modulus', 1);
  T_modulus = value_or_default(params, 'T_modulus', 1);
  T_iterations = value_or_default(params, 'T_iterations', 50);
  pp_iterations = value_or_default(params, 'pp_iterations', 10);
  burn = value_or_default(params, 'burn', 5);
  iterations = value_or_default(params, 'iterations', 20);
  plot_modulus = value_or_default(params, 'plot_modulus', 1);
  talk_modulus = value_or_default(params, 'talk_modulus', 1);
  
  surf_sample = value_or_default(params, 'surf_sample', true);
  
  UU_kern_par_widths = value_or_default(params, 'UU_kern_par_widths', ...
                                        [0.5 * ones(length(UU_KernelParams), 1); 0.1]);
  VV_kern_par_widths = value_or_default(params, 'VV_kern_par_widths', ...
                                        [0.5 * ones(length(VV_KernelParams), 1); 0.1]);
  UV_kern_par_widths = value_or_default(params, 'UV_kern_par_widths', ...
                                        [0.5 * ones(length(UV_KernelParams), 1); 0.1]);
  UCov_kern_par_widths = value_or_default(params, 'UCov_kern_par_widths', ...
                                        [0.5 * ones(length(UCov_KernelParams), 1); 0.1]);
  VCov_kern_par_widths = value_or_default(params, 'VCov_kern_par_widths', ...
                                        [0.5 * ones(length(VCov_KernelParams), 1); 0.1]);
                                      
  init_method = value_or_default(params, 'init_method', InitialisationMethods.None);

  %%%% Setup
  
  % Load path and create objects
  
  generic_startup;
  RFM = hcRFM;
  MCMC = hcMCMC_SS_RFM;
  MCMC.RFM = RFM;
  
  RFM.D_L_U = U_Dim;
  RFM.D_L_V = V_Dim;

  % Load UU array
  
  UU_Data = hc2ArrayData;
  UU_Data.LoadFromFile (UU_Filename, UU_square, UU_undirected);
  Data = UU_Data.Partition (UU_Folds, UU_Fold, Seed);
  delete (UU_Data);
  if UU_FoldFlip
    Data.Flip;
  end
  RFM.data_UU = Data;
  
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

  % Load VV array
  
  VV_Data = hc2ArrayData;
  VV_Data.LoadFromFile (VV_Filename, VV_square, VV_undirected);
  Data = VV_Data.Partition (VV_Folds, VV_Fold, Seed);
  delete (VV_Data);
  if VV_FoldFlip
    Data.Flip;
  end
  RFM.data_VV = Data;
  
  RFM.ObservationModel_VV = VV_ObservationModel;
  RFM.DataPrecision_VV = VV_DataPrecision;
  
  RFM.n_pp_VV = n_pp_VV;
  
  % Setup VV kernel
  
  RFM.arrayKern_VV.name = VV_KernelName;
  RFM.arrayKern_VV.diagNoise = VV_DiagNoise;
  RFM.arrayKern_VV.params = VV_KernelParams;
  RFM.arrayKern_VV.priorParams = VV_KernPriorParams;
  RFM.arrayKern_VV.noiseParams = VV_NoiseParams;
  RFM.arrayKern_VV.priorType = VV_Prior;

  % Load UV array
  
  UV_Data = hc2ArrayData;
  UV_Data.LoadFromFile (UV_Filename, UV_square, UV_undirected);
  if ~UV_FoldRow
    Data = UV_Data.Partition (UV_Folds, UV_Fold, Seed);
  else
    Data = UV_Data.RowPartition (UV_Folds, UV_Fold, Seed);
  end
  delete (UV_Data);
  if UV_FoldFlip
    Data.Flip;
  end
  RFM.data_UV = Data;
  
  RFM.ObservationModel_UV = UV_ObservationModel;
  RFM.DataPrecision_UV = UV_DataPrecision;
  
  RFM.n_pp_UV = n_pp_UV;
  
  % Setup UV kernel
  
  RFM.arrayKern_UV.name = UV_KernelName;
  RFM.arrayKern_UV.diagNoise = UV_DiagNoise;
  RFM.arrayKern_UV.params = UV_KernelParams;
  RFM.arrayKern_UV.priorParams = UV_KernPriorParams;
  RFM.arrayKern_UV.noiseParams = UV_NoiseParams;
  RFM.arrayKern_UV.priorType = UV_Prior;

  % Load UCov array
  
  UCov_Data = hc2ArrayData;
  UCov_Data.LoadFromFile (UCov_Filename, UCov_square, UCov_undirected, true);
  Data = UCov_Data.Partition (UCov_Folds, UCov_Fold, Seed);
  delete (UCov_Data);
  if UCov_FoldFlip
    Data.Flip;
  end
  RFM.data_UCov = Data;
  
  if ~iscell(UCov_ObservationModel)
    UCov_ObservationModel = RepeatCell(UCov_ObservationModel, [RFM.data_UCov.D_X, 1]);
  end
  if ~iscell(UCov_DataPrecision)
    UCov_DataPrecision = RepeatCell(UCov_DataPrecision, [RFM.data_UCov.D_X, 1]);
  end
  RFM.ObservationModel_UCov = UCov_ObservationModel;
  RFM.DataPrecision_UCov = UCov_DataPrecision;
  
  RFM.n_pp_UCov = n_pp_UCov;
  
  % Setup UCov kernel
  
  RFM.arrayKern_UCov.name = UCov_KernelName;
  RFM.arrayKern_UCov.diagNoise = UCov_DiagNoise;
  RFM.arrayKern_UCov.params = UCov_KernelParams;
  RFM.arrayKern_UCov.priorParams = UCov_KernPriorParams;
  RFM.arrayKern_UCov.noiseParams = UCov_NoiseParams;
  RFM.arrayKern_UCov.priorType = UCov_Prior;

  % Load VCov array
  
  VCov_Data = hc2ArrayData;
  VCov_Data.LoadFromFile (VCov_Filename, VCov_square, VCov_undirected, true);
  Data = VCov_Data.Partition (VCov_Folds, VCov_Fold, Seed);
  delete (VCov_Data);
  if VCov_FoldFlip
    Data.Flip;
  end
  RFM.data_VCov = Data;
  
  if ~iscell(VCov_ObservationModel)
    VCov_ObservationModel = RepeatCell(VCov_ObservationModel, [RFM.data_VCov.D_X, 1]);
  end
  if ~iscell(VCov_DataPrecision)
    VCov_DataPrecision = RepeatCell(VCov_DataPrecision, [RFM.data_VCov.D_X, 1]);
  end
  RFM.ObservationModel_VCov = VCov_ObservationModel;
  RFM.DataPrecision_VCov = VCov_DataPrecision;
  
  RFM.n_pp_VCov = n_pp_VCov;
  
  % Setup VCov kernel
  
  RFM.arrayKern_VCov.name = VCov_KernelName;
  RFM.arrayKern_VCov.diagNoise = VCov_DiagNoise;
  RFM.arrayKern_VCov.params = VCov_KernelParams;
  RFM.arrayKern_VCov.priorParams = VCov_KernPriorParams;
  RFM.arrayKern_VCov.noiseParams = VCov_NoiseParams;
  RFM.arrayKern_VCov.priorType = VCov_Prior;
  
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
  MCMC.kern_par_widths.VV = VV_kern_par_widths;
  MCMC.kern_par_widths.UV = UV_kern_par_widths;
  MCMC.kern_par_widths.UCov = UCov_kern_par_widths;
  MCMC.kern_par_widths.VCov = VCov_kern_par_widths;
  
  MCMC.init_method = init_method;

end

