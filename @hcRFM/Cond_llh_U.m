function llh = Cond_llh_U( obj, U_index, ~ )
%COND_LLH_U Calculate llh when U changes
% Detailed explanation goes here
%
% James Lloyd, June 2012

  llh = 0;
  for i = 1:length(obj.data_UU.train_X_v)
    % Which function values change?
    active = (obj.data_UU.train_X_i{i} == U_index) | (obj.data_UU.train_X_j{i} == U_index);
    activegroup = (obj.group_UU.train_X_i{i} == U_index) | (obj.group_UU.train_X_j{i} == U_index);

    % Update cache
    obj.UpdateKernelMatrices_ip_UU (active, i);
    % Data llh at the function values that have changed
    obj.W_UU{i}(active) = obj.K_ip_pp_UU{i}(active, :) * (obj.K_pp_pp_UU{i} \ obj.T_UU{i});
    params.precision = obj.DataPrecision_UU;
    llh = llh + Cond_llh_2array (obj.W_UU{i}(active), obj.data_UU.train_X_v{i}(active), ...
                                 obj.ObservationModel_UU, params);

    obj.group_ip_UU{i} = CreateGPInputPoints (obj.group_UU.train_X_i{i}(activegroup), obj.group_UU.train_X_j{i}(activegroup), obj.U);
    obj.K_group_pp_UU{i} = obj.arrayKern_UU.Matrix (obj.group_ip_UU{i}, obj.pp_UU{i});
    obj.group_w_UU{i} = logistic(obj.K_group_pp_UU{i} * (obj.K_pp_pp_UU{i} \ obj.T_UU{i}), 1);
    llh = llh + Cond_llh_2array (obj.group_w_UU{i}, obj.group_UU.train_X_v{i}(activegroup), obj.ObservationModel_UU, params);

  end
  % Prior for U
  if (~isempty(obj.data_UU.train_X_v))
    % This could be slightly more efficient - not main time sink
    llh = llh + obj.Prior_U; 
  end

end

