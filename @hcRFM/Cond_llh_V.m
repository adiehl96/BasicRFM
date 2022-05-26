function llh = Cond_llh_V( obj, V_index, ~ )
%Cond_llh_V Calculate llh when U changes
% Detailed explanation goes here
%
% James Lloyd, June 2012

  llh = 0;
  for i = 1:length(obj.data_VV.train_X_v)
    % Which function values change?
    active = (obj.data_VV.train_X_i{i} == V_index) | (obj.data_VV.train_X_j{i} == V_index);
    % active = 1:length(obj.data_VV.train_X_i{i});
    % Update cache
    obj.UpdateKernelMatrices_ip_VV (active, i);
    % Data llh at the function values that have changed
    obj.W_VV{i}(active) = obj.K_ip_pp_VV{i}(active, :) * (obj.K_pp_pp_VV{i} \ obj.T_VV{i});
    params.precision = obj.DataPrecision_VV;
    llh = llh + Cond_llh_2array (obj.W_VV{i}(active), obj.data_VV.train_X_v{i}(active), ...
                                 obj.ObservationModel_VV, params);
  end
  for i = 1:length(obj.data_UV.train_X_v)
    % Which function values change?
    active = (obj.data_UV.train_X_j{i} == V_index);
    % active = 1:length(obj.data_UV.train_X_j{i});
    % Update cache
    obj.UpdateKernelMatrices_ip_UV (active, i);
    % Data llh at the function values that have changed
    obj.W_UV{i}(active) = obj.K_ip_pp_UV{i}(active, :) * (obj.K_pp_pp_UV{i} \ obj.T_UV{i});
    params.precision = obj.DataPrecision_UV;
    llh = llh + Cond_llh_2array (obj.W_UV{i}(active), obj.data_UV.train_X_v{i}(active), ...
                                 obj.ObservationModel_UV, params);
  end
  for i = 1:length(obj.data_VCov.train_X_v)
    % Which function values change?
    active = (obj.data_VCov.train_X_i{i} == V_index);
    % active = 1:length(obj.data_VCov.train_X_i{i});
    % Update cache
    obj.UpdateKernelMatrices_ip_VCov (active, i);
    % Data llh at the function values that have changed
    obj.W_VCov{i}(active) = obj.K_ip_pp_VCov{i}(active, :) * (obj.K_pp_pp_VCov{i} \ obj.T_VCov{i});
    params.precision = obj.DataPrecision_VCov{i};
    llh = llh + Cond_llh_2array (obj.W_VCov{i}(active), obj.data_VCov.train_X_v{i}(active), ...
                                 obj.ObservationModel_VCov{i}, params);
  end
  % Prior for U
  if (~isempty(obj.data_VV.train_X_v)) || (~isempty(obj.data_UV.train_X_v)) || ...
     (~isempty(obj.data_VCov.train_X_v))
    llh = llh + obj.Prior_V; % TODO - This could be slightly more efficient
  end

end

