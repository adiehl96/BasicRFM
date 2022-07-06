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
      [obj.T_UU{i}, ~] = gppu_elliptical(obj.T_UU{i}, obj.chol_K_pp_pp_UU{i}, ...
                        @(T) Cond_llh_2array (K_pp_pp_invK_ppip_t * T, obj.data_UU.train_X_v{i}, obj.ObservationModel_UU, params));
    end
  end
end

