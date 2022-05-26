function llh = Cond_llh_pp_UU_No_Update( obj, pp_index, array_index )
%Cond_llh_pp_UU_No_Update Calculate llh when pseudo points change
% Detailed explanation goes here
%
% James Lloyd, June 2012

  i = array_index;
  %obj.UpdateKernelMatrices_pp_UU (pp_index, array_index);
  % Normal distribution of GP - using cholesky for numerical stability
  % In future, make use of rank 1 updates
  llh = - sum(log(diag(obj.chol_K_pp_pp_UU{i}))) - ...
          0.5*(obj.T_UU{i}'*solve_chol(obj.chol_K_pp_pp_UU{i}, obj.T_UU{i}));
  % Data llh
  obj.W_UU{i} = obj.K_ip_pp_UU{i} * (obj.K_pp_pp_UU{i} \ obj.T_UU{i});
  params.precision = obj.DataPrecision_UU;
  llh = llh + Cond_llh_2array (obj.W_UU{i}, obj.data_UU.train_X_v{i}, ...
                               obj.ObservationModel_UU, params);
  % Prior for pseudo points
  llh = llh + obj.Prior_pp_UU (i); % TODO - This could be slightly more efficient

end

