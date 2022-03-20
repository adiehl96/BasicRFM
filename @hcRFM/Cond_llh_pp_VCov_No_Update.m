function llh = Cond_llh_pp_VCov( obj, pp_index, array_index )
%Cond_llh_pp_VCov Calculate llh when pseudo points change
% Detailed explanation goes here
%
% James Lloyd, June 2012

  i = array_index;
  %obj.UpdateKernelMatrices_pp_VCov (pp_index, array_index);
  % Normal distribution of GP - using cholesky for numerical stability
  % In future, make use of rank 1 updates
  llh = - sum(log(diag(obj.chol_K_pp_pp_VCov{i}))) - ...
          0.5*(obj.T_VCov{i}'*solve_chol(obj.chol_K_pp_pp_VCov{i}, obj.T_VCov{i}));
  % Data llh
  obj.W_VCov{i} = obj.K_ip_pp_VCov{i} * (obj.K_pp_pp_VCov{i} \ obj.T_VCov{i});
  params.precision = obj.DataPrecision_VCov{i};
  llh = llh + Cond_llh_2array (obj.W_VCov{i}, obj.data_VCov.train_X_v{i}, ...
                               obj.ObservationModel_VCov{i}, params);
  % Prior for pseudo points
  llh = llh + obj.Prior_pp_VCov (i); % TODO - This could be slightly more efficient

end

