function SampleParamsPrior ( obj )
%SAMPLEPARAMSPRIOR Sample parameters from prior
% Detailed explanation goes here
%
% James Lloyd, July 2012

  % Latent vars
  obj.U = obj.U_sd * randn(size(obj.U));

  % Pseudo points
  for i = 1:length(obj.pp_UU)
    obj.pp_UU{i} = obj.pp_UU_sd * randn(size(obj.pp_UU{i}));
  end
  for i = 1:length(obj.pp_UCov)
    obj.pp_UCov{i} = obj.pp_UCov_sd * randn(size(obj.pp_UCov{i}));
  end

  % GP kernel parameters
  new_params = obj.arrayKern_UU.SampleParamsPrior;
  obj.arrayKern_UU.params = new_params.params;
  obj.arrayKern_UU.diagNoise = new_params.diagNoise;

  new_params = obj.arrayKern_UCov.SampleParamsPrior;
  obj.arrayKern_UCov.params = new_params.params;
  obj.arrayKern_UCov.diagNoise = new_params.diagNoise;

  % Everything has changed, so update all cached quantities
  obj.Init_Cache;

  % GP targetsT_UU
  for i = 1:length(obj.T_UU)
    obj.T_UU{i} = obj.chol_K_pp_pp_UU{i}' * randn(size(obj.T_UU{i}));
  end
  for i = 1:length(obj.T_UCov)
    obj.T_UCov{i} = obj.chol_K_pp_pp_UCov{i}' * randn(size(obj.T_UCov{i}));
  end
  
end

