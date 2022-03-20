function ESS_T( obj, iterations )
%ESS_T Elliptically slice sample T
% Detailed explanation goes here
%
% Written by James Lloyd, June 2012

  % Sample for the UU arrays
  for i = 1:length(obj.T_UU)
    % Precompute SoR mapping
    K_pp_pp_invK_ppip_t = (obj.K_pp_pp_UU{i} \ obj.K_ip_pp_UU{i}')';
    for iter = 1:iterations
      % Perform one ESS step
      % TODO - pass T by reference using object wrapper - better for memory
      params.precision = obj.DataPrecision_UU;
      [obj.T_UU{i} ~] = gppu_elliptical(obj.T_UU{i}, obj.chol_K_pp_pp_UU{i}, ...
                        @(T) Cond_llh_2array (K_pp_pp_invK_ppip_t * T, obj.data_UU.train_X_v{i}, obj.ObservationModel_UU, params));
    end
  end
  % Sample for the VV arrays
  for i = 1:length(obj.T_VV)
    % Precompute SoR mapping
    K_pp_pp_invK_ppip_t = (obj.K_pp_pp_VV{i} \ obj.K_ip_pp_VV{i}')';
    for iter = 1:iterations
      % Perform one ESS step
      % TODO - pass T by reference using object wrapper - better for memory
      params.precision = obj.DataPrecision_VV;
      [obj.T_VV{i} ~] = gppu_elliptical(obj.T_VV{i}, obj.chol_K_pp_pp_VV{i}, ...
                        @(T) Cond_llh_2array (K_pp_pp_invK_ppip_t * T, obj.data_VV.train_X_v{i}, obj.ObservationModel_VV, params));
    end
  end
  % Sample for the UV arrays
  for i = 1:length(obj.T_UV)
    % Precompute SoR mapping
    K_pp_pp_invK_ppip_t = (obj.K_pp_pp_UV{i} \ obj.K_ip_pp_UV{i}')';
    for iter = 1:iterations
      % Perform one ESS step
      % TODO - pass T by reference using object wrapper - better for memory
      params.precision = obj.DataPrecision_UV;
      [obj.T_UV{i} ~] = gppu_elliptical(obj.T_UV{i}, obj.chol_K_pp_pp_UV{i}, ...
                        @(T) Cond_llh_2array (K_pp_pp_invK_ppip_t * T, obj.data_UV.train_X_v{i}, obj.ObservationModel_UV, params));
    end
  end
  % Sample for the UCov arrays
  for i = 1:length(obj.T_UCov)
    % Precompute SoR mapping
    K_pp_pp_invK_ppip_t = (obj.K_pp_pp_UCov{i} \ obj.K_ip_pp_UCov{i}')';
    for iter = 1:iterations
      % Perform one ESS step
      % TODO - pass T by reference using object wrapper - better for memory
      params.precision = obj.DataPrecision_UCov{i};
      [obj.T_UCov{i} ~] = gppu_elliptical(obj.T_UCov{i}, obj.chol_K_pp_pp_UCov{i}, ...
                        @(T) Cond_llh_2array (K_pp_pp_invK_ppip_t * T, obj.data_UCov.train_X_v{i}, obj.ObservationModel_UCov{i}, params));
    end
  end
  % Sample for the VCov arrays
  for i = 1:length(obj.T_VCov)
    % Precompute SoR mapping
    K_pp_pp_invK_ppip_t = (obj.K_pp_pp_VCov{i} \ obj.K_ip_pp_VCov{i}')';
    for iter = 1:iterations
      % Perform one ESS step
      % TODO - pass T by reference using object wrapper - better for memory
      params.precision = obj.DataPrecision_VCov{i};
      [obj.T_VCov{i} ~] = gppu_elliptical(obj.T_VCov{i}, obj.chol_K_pp_pp_VCov{i}, ...
                        @(T) Cond_llh_2array (K_pp_pp_invK_ppip_t * T, obj.data_VCov.train_X_v{i}, obj.ObservationModel_VCov{i}, params));
    end
  end
end

