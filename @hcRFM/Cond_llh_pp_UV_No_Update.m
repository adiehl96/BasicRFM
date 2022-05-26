function llh = Cond_llh_pp_UV( obj, pp_index, array_index )
%Cond_llh_pp_UV Calculate llh when pseudo points change
% Detailed explanation goes here
%
% James Lloyd, June 2012

  i = array_index;
  %obj.UpdateKernelMatrices_pp_UV (pp_index, array_index);
  % Normal distribution of GP - using cholesky for numerical stability
  % In future, make use of rank 1 updates
  llh = - sum(log(diag(obj.chol_K_pp_pp_UV{i}))) - ...
          0.5*(obj.T_UV{i}'*solve_chol(obj.chol_K_pp_pp_UV{i}, obj.T_UV{i}));
  % Data llh
  obj.W_UV{i} = obj.K_ip_pp_UV{i} * (obj.K_pp_pp_UV{i} \ obj.T_UV{i});
  params.precision = obj.DataPrecision_UV;
  llh = llh + Cond_llh_2array (obj.W_UV{i}, obj.data_UV.train_X_v{i}, ...
                               obj.ObservationModel_UV, params);
  % Prior for pseudo points
  llh = llh + obj.Prior_pp_UV (i); % TODO - This could be slightly more efficient

end

